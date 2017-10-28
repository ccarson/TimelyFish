-- ========================================================
-- Author:		Doran Dahle
-- Create date: 09/27/2012
-- Description:	Selects Pfos Event records for the SL Pfos
-- status maintenance (XF.174.00) screen
-- ========================================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
09-27-2012  Doran Dahle New
						

===============================================================================
*/

Create PROCEDURE [dbo].[pXF174cftPfosEvent_Event] 
	@PfosEvent varchar (10) 
	AS 
    	SELECT * 
	FROM cftPfosEvent 
	WHERE pfosEvent Like @PfosEvent
	ORDER BY pfosEvent
