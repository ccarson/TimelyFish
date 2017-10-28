
Create PROC ProjInv_ProjTask_LotSerConsumed
	@InvtID	    varchar(30),
	@SiteID	    varchar(10),
        @WhseLoc    varchar(10),
        @TaskID     varchar(32),
        @ProjectID  varchar(16),
        @LotSerNbr  varchar(25),
        @BatNbr     varchar(10)
 AS


-- Get All Project Allocated Inventory that all is consumed on Shippers and Issues.
SELECT SUM(x.QtyRemainToIssue) - SUM(ISNULL(D.LS_QtyAllocated,0))
  FROM VP_ProjIN_InProjAllocLot_byWhse X WITH(NOLOCK)
       Left Join (SELECT L.Invtid, L.SiteId,L.LotSerNbr,L.WhseLoc,L.ProjectID,L.TaskID, Sum(L.QtyAllocated) as LS_QtyAllocated From inprjallocationlot L WITH(NOLOCK)
                  Where l.InvtID = @InvtID
                  AND l.SiteID = @SiteID
                  AND l.LotSerNbr = @LotSerNbr
                  AND l.Whseloc = @WhseLoc
                  AND l.ProjectID = @ProjectID
                  AND l.TaskID = @TaskID
                  AND l.SrcType IN ('IS','SH','RN')
                  AND l.OrdNbr <> @BatNbr
                  Group BY L.Invtid, L.SiteId, L.LotSerNbr, L.WhseLoc,L.ProjectID,L.TaskID) As D
        ON  D.Invtid = X.InvtID
        AND D.SiteId = X.SiteID
        AND D.WhseLoc = X.WhseLoc
        AND D.ProjectID = X.ProjectID
        AND D.TaskID = X.TaskID
        AND D.LotSerNbr = X.LotSerNbr
 WHERE x.InvtID = @InvtID
   AND x.SiteID = @SiteId
   AND x.WhseLoc = @WhseLoc
   AND x.ProjectID = @ProjectID
   AND x.TaskID = @TaskID
   AND x.LotSerNbr = @LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_ProjTask_LotSerConsumed] TO [MSDSL]
    AS [dbo];

