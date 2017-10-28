-- ========================================================
-- Author:		Doran Dahle
-- Create date: 09/27/2012
-- Description:	Selects Pfos Status records for the SL Pfos
-- status maintenance (XF.178.00) screen
-- ========================================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
09-27-2012  Doran Dahle New
						

===============================================================================
*/

Create PROCEDURE [dbo].[pXF178cftPfosStatus_Name] 
	@name varchar (20) 
	AS 
    	SELECT * 
	FROM cftPfosStatus 
	WHERE name Like @name
	ORDER BY Name
