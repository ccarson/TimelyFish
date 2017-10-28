
CREATE FUNCTION [dbo].[PGGetBaseSource]
(
      @PigGroupID VARCHAR(5)
)

RETURNS VARCHAR(8000)
AS
BEGIN

----for test
--declare @PigGroupID varchar(5)
--set @PigGroupID = '19977'
----end test

DECLARE @SourceTable table
(     PigGroupID char(10)
,     SourcePigGroupID char(10)
,     SourceProject char(16))


INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject)
SELECT      @PigGroupID, SourcePigGroupID, SourceProject
FROM  dbo.cftPGInvTran cftPGInvTran (NOLOCK)
WHERE RTRIM(cftPGInvTran.PigGroupID) = RTRIM(@PigGroupID)
AND   cftPGInvTran.TranTypeID IN ('TI','MI','PP')
AND cftPGInvTran.Reversal <> '1'
WHILE (1=1)
BEGIN

      INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject)
      SELECT      DISTINCT cftPGInvTran.PigGroupID, cftPGInvTran.SourcePigGroupID, cftPGInvTran.SourceProject
      FROM  dbo.cftPGInvTran cftPGInvTran (NOLOCK)
      INNER JOIN @SourceTable SourceTable
            ON SourceTable.SourcePigGroupID = cftPGInvTran.PigGroupID
	  WHERE cftPGInvTran.Reversal <> '1'

      IF (SELECT COUNT(*) RecCt FROM @SourceTable A WHERE RTRIM(A.SourcePigGroupID) <> '' AND NOT EXISTS (SELECT * FROM @SourceTable B WHERE B.PigGroupID = A.SourcePigGroupID)) = 0
            BREAK
      ELSE
            CONTINUE

END

-- CONCATENATE
DECLARE @Concat as varchar(8000)
SELECT @Concat = isnull(@Concat + ', ', '') + ltrim(rtrim(PJProj.project_desc))
from @SourceTable SourceTable
inner JOIN PJProj PJProj (NOLOCK)
ON RTRIM(PJProj.Project) = RTRIM(SourceTable.SourceProject)
where RTRIM(SourceTable.SourcePigGroupID) = ''
group by PJProj.project_desc
order by PJProj.project_desc

-- result
RETURN @Concat 

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetBaseSource] TO [SE\Analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetBaseSource] TO [SE\ssis_datareader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetBaseSource] TO [SE\SQLSvcHelene]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetBaseSource] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetBaseSource] TO [MSDSL]
    AS [dbo];

