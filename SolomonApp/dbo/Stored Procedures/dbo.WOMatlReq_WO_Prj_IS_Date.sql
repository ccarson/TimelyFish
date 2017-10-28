 CREATE PROCEDURE WOMatlReq_WO_Prj_IS_Date
   @InvtID        varchar( 30 ),
   @SiteID        varchar( 10 ),
	@WhseLoc			varchar( 10 ),
   @CustID        varchar( 15 ),
   @PlanEndBeg    smalldatetime,
   @PlanEndEnd    smalldatetime,
   @WOStatus      varchar( 1 )
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN WOHeader
               ON WOMatlReq.WONbr = WOHeader.WONbr
               LEFT JOIN PJProj
               ON WOMatlReq.WONbr = PJProj.Project
   WHERE       WOMatlReq.Invtid = @InvtID and
               WOMatlReq.SiteID LIKE @SiteID and
               WOMatlReq.WhseLoc LIKE @WhseLoc and
               WOHeader.CustID LIKE @CustID and
               WOHeader.PlanEnd Between @PlanEndBeg and @PlanEndEnd and
               WOHeader.Status LIKE @WOStatus
   ORDER BY    WOMatlReq.DateReqd DESC, WOMatlReq.WONbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WO_Prj_IS_Date] TO [MSDSL]
    AS [dbo];

