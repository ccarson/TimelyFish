 CREATE PROCEDURE WOMatlReq_WO_Prj_IS
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN WOHeader
               ON WOMatlReq.WONbr = WOHeader.WONbr
               LEFT JOIN PJProj
               ON WOMatlReq.WONbr = PJProj.Project
   WHERE       WOMatlReq.Invtid = @InvtID and
               WOMatlReq.SiteID LIKE @SiteID
   ORDER BY    WOMatlReq.WONbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WO_Prj_IS] TO [MSDSL]
    AS [dbo];

