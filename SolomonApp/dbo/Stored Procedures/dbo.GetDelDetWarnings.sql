 CREATE  PROCEDURE GetDelDetWarnings @FiscYr SMALLINT
AS
DECLARE @ModList CHAR(26)
CREATE  TABLE   #Deleted (Module CHAR(2))

SET NOCOUNT ON

SELECT  @ModList=''

IF (SELECT (CONVERT(INT,SUBSTRING(g.PerNbr,1,4))*g.NbrPer+
            CONVERT(INT,SUBSTRING(g.PerNbr,5,2))-g.PerRetTran-1)/g.NbrPer

FROM GLSetup g) >= @FiscYr

INSERT #Deleted VALUES('GL')

IF (SELECT (CONVERT(INT,SUBSTRING(s.CurrPerNbr,1,4))*g.NbrPer+
            CONVERT(INT,SUBSTRING(s.CurrPerNbr,5,2))-s.PerRetTran-1)/g.NbrPer

FROM GLSetup g, APSetup s) >= @FiscYr

INSERT #Deleted VALUES('AP')

IF (SELECT (CONVERT(INT,SUBSTRING(s.CurrPerNbr,1,4))*g.NbrPer+
            CONVERT(INT,SUBSTRING(s.CurrPerNbr,5,2))-s.PerRetTran-1)/g.NbrPer

FROM GLSetup g, ARSetup s) >= @FiscYr

INSERT #Deleted VALUES('AR')

IF (SELECT (CONVERT(INT,SUBSTRING(s.CurrPerNbr,1,4))*g.NbrPer+
            CONVERT(INT,SUBSTRING(s.CurrPerNbr,5,2))-s.PerRetTran-1)/g.NbrPer

FROM GLSetup g, CASetup s) >= @FiscYr

INSERT #Deleted VALUES('CA')

IF (SELECT (CONVERT(INT,SUBSTRING(s.PerNbr,1,4))*g.NbrPer+
            CONVERT(INT,SUBSTRING(s.PerNbr,5,2))-s.RetQtrChecks-1)/g.NbrPer

FROM GLSetup g, PRSetup s) >= @FiscYr

INSERT #Deleted VALUES('PR')

UPDATE #Deleted
SET @ModList = COALESCE(RTRIM(@ModList),'')+', '+Module, Module=Module

FROM #Deleted

IF LEN(@ModList)= 4
SELECT @ModList=SUBSTRING(@ModList,3,3)+' module'

ELSE IF LEN(@ModList)>4
SELECT @ModList=RTRIM(SUBSTRING(@ModList,3,18))+' modules'

SET NOCOUNT OFF

SELECT @ModList



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetDelDetWarnings] TO [MSDSL]
    AS [dbo];

