
-- =============================================
-- Author:		Doran Dahle
-- Create date: 5/13/2015
-- Description:	Used to add WEIGH LOAD to Feeder loads
-- =============================================
CREATE PROCEDURE [dbo].[cfp_UpdateFeederLoads] 
	
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements
SET NOCOUNT ON;

UPDATE dbo.cftPM 
SET Comment = 'WEIGH LOAD; ' +RTRIM ( Comment ) 
WHERE PMID IN
	(SELECT pm.PMID 
	FROM dbo.cftPM pm
		INNER JOIN dbo.cftPigType ON pm.PigTypeID = dbo.cftPigType.PigTypeID
	WHERE pm.MovementDate >= CONVERT(date, getdate())
--		AND DATEPART(hh,pm.ArrivalTime) >= '8' And DATEPART(hh,pm.ArrivalTime) <='17' 
		AND dbo.cftPigType.PigTypeDesc Like '%feeder%'
		AND pm.PMTypeID='01'
		AND pm.Comment not like '%WEIGH LOAD%')
END
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_UpdateFeederLoads] TO [MSDSL]
    AS [dbo];

