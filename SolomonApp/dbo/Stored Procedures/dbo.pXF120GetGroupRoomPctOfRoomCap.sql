
----------------------------------------------------------------------------------------
--    Purpose: To return the percentage that the specified
--          room is of the total (sum) percentage of the assigned
--          rooms for the group (a group may have multiple rooms, but occupy 
--          the whole barn. 
--          NOTE: The procedure will return 1 for NULL values
--    Author: Timothy Jones
--    Date: 9/1/2005
--    Program Usage: XF120
--    Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120GetGroupRoomPctOfRoomCap]
      @PigGroupID As varchar(10),
      @RoomNbr as varchar(10)
      AS

      SELECT RoomPctOfTot =
      IsNull((SELECT r.BrnCapPrct FROM cftPigGroupRoom pgr
      LEFT JOIN cftPigGroup g on pgr.PigGroupID = g.PigGroupID
      LEFT JOIN cftRoom r on g.SiteContactID = r.ContactID 
            AND g.BarnNbr = r.BarnNbr 
            AND pgr.RoomNbr = r.RoomNbr
      WHERE pgr.PigGroupID = @PigGroupID
      AND pgr.RoomNbr = @RoomNbr),1)
      /
      IsNull((SELECT Sum(r.BrnCapPrct) FROM cftPigGroupRoom pgr
      LEFT JOIN cftPigGroup g on pgr.PigGroupID = g.PigGroupID
      LEFT JOIN cftRoom r on g.SiteContactID = r.ContactID 
            AND g.BarnNbr = r.BarnNbr 
            AND pgr.RoomNbr = r.RoomNbr
      WHERE pgr.PigGroupID = @PigGroupID),1)
