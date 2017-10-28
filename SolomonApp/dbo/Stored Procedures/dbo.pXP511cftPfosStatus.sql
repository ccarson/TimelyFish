-- ========================================================
-- Author:		Doran Dahle
-- Create date: 10/05/2012
-- Description:	Selects Pfos Status records for the SL Pfos
-- Pig Group maintenance (XP.511.00) screen
-- ========================================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
09-27-2012  Doran Dahle New
						

===============================================================================
*/

CREATE PROCEDURE [dbo].[pXP511cftPfosStatus] 
	@Name varchar (10) 
	AS 
    	SELECT * 
	FROM [dbo].[cftPfosStatus]
	WHERE [Name] Like @Name And Active <> 0
	ORDER BY [IDPfosStatus],[Name]
	
