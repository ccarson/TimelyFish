


/****** Object:  Stored Procedure dbo.cfpLoadMarket    Script Date: 12/20/2005 12:08:53 PM ******/
CREATE  Procedure [dbo].[cfpLoadMarket]

AS
BEGIN

DECLARE @DayT AS smalldatetime

--Select @DayT = '2011-02-01'
Select @DayT = '2013-12-31'


WHILE @DayT<>'2023-12-31'
	BEGIN

	INSERT INTO cftPigMktValue(CF01,CF02,CF03,CF04,CF05,CF06,CF07,CF08,CF09,CF10,CF11,CF12,
	Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,MktAvg,MktAct,
	MktDate,NoteId,Percentage,WkDet)

	SELECT CF01='',CF02='',CF03='',CF04='',CF05='2005-01-01',CF06='2005-01-01',CF07=0,CF08=0,CF09=0,CF10=0,CF11=0,CF12=0,
	Crtd_DateTime='2005-12-19',Crtd_Prog='IMPORT',Crtd_User='IMPORT',Lupd_DateTime='2005-01-01',Lupd_Prog='IMPORT',Lupd_User='IMPORT',MktAvg=0,MktAct=0,
	MktDate=@DayT,NoteId=0,Percentage=.45,WkDet='0000'


	Select @DayT = DATEADD(day, 1, @DayT)
		
	END


END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpLoadMarket] TO [MSDSL]
    AS [dbo];

