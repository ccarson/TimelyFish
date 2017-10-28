 CREATE PROCEDURE WOSOSched_InvtID_Filter
   	@InvtID     	varchar( 30 ),
   	@SiteID     	varchar( 10 ),
   	@CustID     	varchar( 15 ),
	@OrdDateFrom   	smallDateTime,
	@OrdDateTo	smallDateTime,
	@Status		varchar( 1 ),
	@SOType		varchar( 4 ),
	@CompFG		varchar( 1 )

AS
	if @CompFG = 'C'
		-- Components - Sales Items
	   SELECT      	L.*,
			H.BuildAvailDate,
			H.BuildInvtId,
			H.BuildQty,
			H.BuildSiteId,
			H.CpnyId,
			H.CustId,
			H.CustOrdNbr,
			H.OrdDate,
			H.OrdNbr,
			H.SoTypeId,
			H.Status,
			S.*
	   FROM        	SOLine L (nolock)
					LEFT JOIN SOHeader H (nolock)
						ON L.CpnyID = H.CpnyID and L.OrdNbr = H.OrdNbr
	               	JOIN SOSched S (nolock)
						ON L.CpnyID = S.CpnyID and L.OrdNbr = S.OrdNbr and L.LineRef = S.LineRef
	   WHERE       	L.InvtID = @InvtID and
	               	S.SiteID LIKE @SiteID and
	               	H.CustID LIKE @CustID and
	               	H.OrdDate Between @OrdDateFrom and @OrdDateTo and
			S.Status LIKE @Status and
			H.SOTypeID LIKE @SOType
	   ORDER BY    	S.OrdNbr DESC, S.LineRef, S.SchedRef
	else
		-- Kit Assemblies
	   SELECT      	L.*,
			H.BuildAvailDate,
			H.BuildInvtId,
			H.BuildQty,
			H.BuildSiteId,
			H.CpnyId,
			H.CustId,
			H.CustOrdNbr,
			H.OrdDate,
			H.OrdNbr,
			H.SoTypeId,
			H.Status,
			S.*
	   FROM        	SOLine L (nolock)
					LEFT JOIN SOHeader H (nolock)
						ON L.CpnyID = H.CpnyID and L.OrdNbr = H.OrdNbr
	               	JOIN SOSched S (nolock)
						ON L.CpnyID = S.CpnyID and L.OrdNbr = S.OrdNbr and L.LineRef = S.LineRef
	   WHERE       	H.BuildInvtID = @InvtID and
	               	H.BuildSiteID LIKE @SiteID and
	               	H.CustID LIKE @CustID and
	               	H.OrdDate Between @OrdDateFrom and @OrdDateTo and
			H.Status LIKE @Status and
			H.SOTypeID LIKE @SOType
	   ORDER BY    	H.OrdNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOSched_InvtID_Filter] TO [MSDSL]
    AS [dbo];

