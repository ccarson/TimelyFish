
----------------------------------------------------------------------------------------
--	Purpose: PV for piggroup lookup 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120cftPigGroup_PV]
	@ContactID varchar (10), 
	@BarnNbr varchar (6), 
	@RoomNbr varchar (10), 
	@Reversal1 smallint, 
	@Reversal2 smallint,  --workaround for how solomon parses a pv (can't reuse same parameter like proc could)
	@PigGroupID varchar (10)
	AS 
    	SELECT p.* 
    -- 20120927 sripley added nolock hints to reduce blocking
	FROM cftPigGroup p (nolock) 
	JOIN cftPGStatus pgs (nolock)  ON p.PGStatusID = pgs.PGStatusID 
	LEFT JOIN cftPigGroupRoom r (nolock)  ON p.PigGroupId = r.PigGroupId
	WHERE p.SiteContactId = @ContactID
	AND p.BarnNbr = @BarnNbr 
	AND p.PigGroupId LIKE @PigGroupID
	AND (r.RoomNbr = @RoomNbr OR r.RoomNbr Is Null)
	AND ( (@Reversal1=1) OR (@Reversal2=0 AND pgs.Status_PA = 'A' AND pgs.Status_IN='A') )
	ORDER BY p.PigGroupId

 
