 Create Proc ProjInv_PhysInvtReview
    @InvtID  Varchar(30),
    @SiteID  Varchar(10),
    @WhseLoc Varchar(10)
AS

SELECT InvtID, SiteID, WhseLoc, SUM(QtyRemainToIssue) ProjQtyOnHand
  FROM InvProjAlloc
 WHERE InvtID = @InvtID
   AND SiteID = @SiteID
   AND WhseLoc = @WhseLoc
GROUP BY InvtID, SiteID, WhseLoc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_PhysInvtReview] TO [MSDSL]
    AS [dbo];

