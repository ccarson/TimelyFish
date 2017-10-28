

--*************************************************************
--	Purpose:DBNav for PS Defect Type	
--	Author: Nick Honetschlager
--	Date: 12/04/2014
--	Usage: PS Defect Type Maintenance (XP.521.00)	 
--	Parms: @pkrContactID, @pkrDefectCode
--*************************************************************

CREATE PROCEDURE [dbo].[pXP521cftPSDefectType] 
	@defectTypeID as varchar(6)
AS

	SELECT *
	FROM cftPSDefectType
	WHERE DefectTypeID LIKE @defectTypeID
	ORDER BY DefectTypeID
	

