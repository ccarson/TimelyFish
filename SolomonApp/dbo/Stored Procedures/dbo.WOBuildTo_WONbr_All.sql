 CREATE PROCEDURE WOBuildTo_WONbr_All
   @WONbr       varchar( 16 ),
   @Status      varchar( 1 ),
   @LineNbrbeg  smallint,
   @LineNbrend  smallint
AS
   SELECT       *
   FROM         WOBuildTo LEFT JOIN Inventory
                ON WOBuildTo.InvtID = Inventory.InvtID
   WHERE        WOBuildTo.WONbr = @WONbr and
                WOBuildTo.Status LIKE @Status and
                WOBuildTo.LineNbr Between @LineNbrbeg and @LineNbrend
   ORDER BY     WOBuildTo.WONbr, WOBuildTo.Status, WOBuildTo.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOBuildTo_WONbr_All] TO [MSDSL]
    AS [dbo];

