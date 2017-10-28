CREATE PROCEDURE [dbo].[cfp_EQUIPMENT_ODOMETER_READINGS]
	@EquipID varchar(10)
	,@StartDate smalldatetime 
	,@EndDate smalldatetime 
AS

SELECT smSvcEquipment.EquipID
	, RTRIM(smSvcEquipment.Descr) AS Descr
	, MAX(smSvcReadings.Reading) - MIN(smSvcReadings.Reading) AS Miles 
FROM SolomonApp.dbo.smSvcReadings smSvcReadings(NOLOCK) 
LEFT JOIN SolomonApp.dbo.smSvcEquipment (NOLOCK) 
	ON smSvcEquipment.EquipID = smSvcReadings.EquipID
WHERE smSvcReadings.EquipID = @EquipID 
AND ReadDate BETWEEN @StartDate AND @EndDate 
GROUP BY smSvcEquipment.EquipID
		,smSvcEquipment.Descr
