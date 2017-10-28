 CREATE PROCEDURE WOINTran_Released
   @InvtID    varchar( 30 ),
   @SiteID    varchar( 10 ),
   @WhseLoc   varchar( 10 )
AS
   SELECT     *
   FROM       INTran
   WHERE      InvtID =  @InvtID and
              SiteID LIKE @SiteID and
              WhseLoc LIKE @WhseLoc and
              Rlsed = 1
   ORDER BY   TranDate DESC, JrnlType, TranType


