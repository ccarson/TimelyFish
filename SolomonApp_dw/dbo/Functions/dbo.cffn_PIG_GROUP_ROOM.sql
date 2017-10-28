

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 4/10/2012
-- Description:	Takes multiple rooms assigned to the same Pig Group at the same site and puts them in a single string.
-- ===================================================================
	CREATE FUNCTION [dbo].[cffn_PIG_GROUP_ROOM] 
	( 
		@SiteID VARCHAR(32)
	   ,@PigGroupID VARCHAR(32) 
	) 
	RETURNS VARCHAR(8000) 
	AS 
	BEGIN 
		DECLARE @r VARCHAR(8000) 
		SELECT @r = ISNULL(@r+',', '') + rtrim(rm.RoomNbr) 
			FROM (
			
			Select Distinct right(rtrim(pg.ProjectID),4) as 'SiteID', pgr.PigGroupID, pgr.RoomNbr
			from [$(SolomonApp)].dbo.cftPigGroupRoom pgr
			left join [$(SolomonApp)].dbo.cftPigGroup pg
			on pgr.PigGroupID = pg.PigGroupID) rm
			
			WHERE rm.SiteID = @SiteID 
			and rm.PigGroupID = @PigGroupID
		RETURN @r 
	END 

