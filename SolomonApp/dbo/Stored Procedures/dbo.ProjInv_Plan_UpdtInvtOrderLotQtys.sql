 create proc ProjInv_Plan_UpdtInvtOrderLotQtys
	@InvtID	Varchar(30),
	@SiteID	Varchar(10),
	@WhseLoc VarChar(10),
	@LotSerNbr VarChar(25),
	@QtyAvailUpdateMode	smallint,	-- 0: CPS Off; 1: CPS On
	@QtyPrec smallint,
	@LUpd_Prog VarChar(8),
	@LUpd_User VarChar(10)
	
as
	set nocount on
        SET DEADLOCK_PRIORITY LOW ---Added this statement to eliminate 1205 errors during inventory release process - Microsoft (MBSC)

	declare @StkItem	smallint
	declare	@OptWOFirmRlsedDemand char (1)

	SELECT @OptWOFirmRlsedDemand = Left(S4Future11,1)
	  FROM WOSetup WITH(NOLOCK)
	 WHERE Init = 'Y'

	-- Fetch information from Inventory.
	SELECT @StkItem = StkItem
	  FROM Inventory WITH(NOLOCK)
	 WHERE InvtID = @InvtID

	if (@StkItem <> 1)
		return
	-- --------------------------------------------------------------------------------
	-- LotSerMst - Update the quantity allocated for each bin.
	-- --------------------------------------------------------------------------------
	
	UPDATE l
	   SET PrjINQtyAllocPORet = Coalesce(D.PrjINQtyAllocPORet, 0),	
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM LotSerMst l LEFT JOIN (SELECT i.InvtID, i.SiteID, i.WhseLoc, i.LotSerNbr,
                                        SUM(i.QtyAllocated) AS PrjINQtyAllocPORet
                                   FROM INPrjAllocationLot i WITH(NOLOCK)
	                              WHERE i.InvtID = @InvtID
	                                AND i.SiteID = @SiteID 
	                                AND i.WhseLoc = @WhseLoc
	                                AND i.LotSerNbr = @LotSerNbr
                                    AND i.SrcType = 'RN'
                                  GROUP BY i.InvtID, i.SiteID, i.Whseloc, i.LotSerNbr) AS D
                        ON l.InvtID = D.InvtID
                       AND l.SiteID = D.SiteID
                       AND l.WhseLoc = D.WhseLoc
                       AND l.LotSerNbr = D.LotSerNbr
     WHERE l.InvtID = @InvtID
       AND l.SiteID = @SiteID
       AND l.WhseLoc = @Whseloc
       AND l.LotSerNbr = @LotSerNbr
	
    UPDATE LotSerMst
       SET QtyAvail = round(QtyOnHand
            - QtyAlloc
            - QtyAllocBM
            - QtyAllocIN
            - QtyAllocPORet
            - QtyAllocSD
            - QtyAllocSO
            - QtyShipNotInv
            - QtyAllocProjIN
            + PrjINQtyAlloc
            + PrjINQtyAllocSO
            + PrjINQtyShipNotInv
            + PrjINQtyAllocIN
            + PrjINQtyAllocPORet
            - case when @OptWOFirmRlsedDemand in ('F','R') then QtyWORlsedDemand else 0 End,
              @QtyPrec)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND LotSerNbr = @LotSerNbr
      AND WhseLoc = @WhseLoc
      AND EXISTS (SELECT *
                    FROM LocTable l WITH(NOLOCK)
                   WHERE l.SiteID = @SiteID
                     AND l.WhseLoc = LotSerMst.WhseLoc
                     AND l.InclQtyAvail = 1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Plan_UpdtInvtOrderLotQtys] TO [MSDSL]
    AS [dbo];

