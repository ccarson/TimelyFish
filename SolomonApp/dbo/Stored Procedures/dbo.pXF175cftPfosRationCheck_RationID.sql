-- ========================================================
-- Author:		Doran Dahle
-- Create date: 09/27/2012
-- Description:	Selectsrecords for the SL Pfos
-- Feed Incompatibility maintenance (XF.175.00) screen
-- ========================================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
09-27-2012  Doran Dahle New
						

===============================================================================
*/

Create PROCEDURE [dbo].[pXF175cftPfosRationCheck_RationID] 
	@RationID varchar (30), 
	@RationIC varchar (30) 
	AS 
    	SELECT * 
	FROM cftPfosRationCheck 
	WHERE RationID like @RationID
	and RationIC like @RationIC
	ORDER BY RationID
