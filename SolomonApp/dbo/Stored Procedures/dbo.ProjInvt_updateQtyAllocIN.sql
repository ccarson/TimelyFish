 create proc ProjInvt_updateQtyAllocIN
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@LotSerNbr	Varchar(25)

AS
    DECLARE @DecPlQty int
    SELECT @DecPlQty = DecPlQty
      FROM INSETup WITH(NOLOCK)

    UPDATE M
       SET QtyAllocIN = round(isnull(D.QtyAllocIN, 0), @DecPlQty)
      FROM LotSerMst M LEFT JOIN (SELECT t.InvtID, t.SiteID, t.WhseLoc, t.LotSerNbr,
                                         QtyAllocIN = ROUND(SUM(CASE WHEN t.TranSrc = 'IN' 
                                                                          AND t.Crtd_Prog not like 'SD%' 
                                                                     THEN -t.InvtMult * t.Qty 
                                                                     ELSE 0 END), @DecPlQty)
                                    FROM LotSerT t JOIN LocTable l
                                                   ON t.SiteID = l.SiteID
                                                  AND t.WhseLoc = l.WhseLoc
                                   WHERE t.InvtMult * t.Qty < 0
                                     AND t.Rlsed = 0
                                     AND t.TranType IN ('II','IN','DM','TR','AS','AJ')
                                     AND l.InclQtyAvail = 1
                                     AND t.InvtID = @InvtID
                                     AND t.SiteID = @SiteID
                                     AND t.LotSerNbr = @LotSerNbr
                                     AND t.WhseLoc = @WhseLoc
                                    group by t.InvtID, t.SiteID, t.WhseLoc, t.LotSerNbr) D
                          ON M.InvtID = D.InvtID
                         AND M.SiteID = D.SiteID
                         AND M.WhseLoc = D.WhseLoc
                         AND M.LotSerNbr = D.LotSerNbr
    WHERE M.InvtID = @InvtID
      AND M.LotSerNbr = @LotSerNbr
      AND M.SiteID = @SiteID
      AND M.WhseLoc = @WhseLoc
if @@error != 0 return(@@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInvt_updateQtyAllocIN] TO [MSDSL]
    AS [dbo];

