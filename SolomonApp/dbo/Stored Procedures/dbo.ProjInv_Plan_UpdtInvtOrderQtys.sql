 create proc ProjInv_Plan_UpdtInvtOrderQtys
	@InvtID	Varchar(30),
	@SiteID	Varchar(10),
	@WhseLoc VarChar(10),
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
	-- Location - Update the quantity allocated for each bin.
	-- --------------------------------------------------------------------------------
	
	UPDATE l
	   SET PrjINQtyAllocPORet = Coalesce(D.PrjINQtyAllocPORet, 0),	
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM Location l LEFT JOIN (SELECT i.InvtID, i.SiteID, i.WhseLoc,
                                        SUM(i.QtyAllocated) AS PrjINQtyAllocPORet
                                   FROM INPrjAllocation i WITH(NOLOCK)
	                              WHERE i.InvtID = @InvtID
	                                AND i.SiteID = @SiteID 
	                                AND i.WhseLoc = @WhseLoc
                                    AND i.SrcType = 'RN'
                                  GROUP BY i.InvtID, i.SiteID, i.Whseloc) AS D
                        ON l.InvtID = D.InvtID
                       AND l.SiteID = D.SiteID
                       AND l.WhseLoc = D.WhseLoc
     WHERE l.InvtID = @InvtID
       AND l.SiteID = @SiteID
       AND l.WhseLoc = @Whseloc
	
	UPDATE Location
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
            + PrjINQtyShipNotInv
            + PrjINQtyAllocSO
            + PrjINQtyAllocIN
            + PrjINQtyAllocPORet
            - case when @OptWOFirmRlsedDemand in ('F','R') then QtyWORlsedDemand else 0 End
            - case when @OptWOFirmRlsedDemand = 'F' then S4Future03 else 0 end,
           @QtyPrec)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND WhseLoc = @WhseLoc
      AND EXISTS (SELECT *
                    FROM LocTable l
                   WHERE l.SiteID = @SiteID
                     AND l.WhseLoc = Location.WhseLoc
                     AND l.InclQtyAvail = 1)

	-- --------------------------------------------------------------------------------
	-- ItemSite -
	-- --------------------------------------------------------------------------------
	UPDATE i
	   SET PrjINQtyAllocPORet = Coalesce(D.PrjINQtyAllocPORet, 0),	
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM ItemSite i LEFT JOIN (SELECT l.InvtID, l.SiteID,
                                        SUM(l.QtyAllocated) AS PrjINQtyAllocPORet
                                   FROM INPrjAllocation l WITH(NOLOCK)
	                              WHERE l.InvtID = @InvtID
	                                AND l.SiteID = @SiteID 
                                    AND l.SrcType = 'RN'
                                  GROUP BY l.InvtID, l.SiteID) AS D
                        ON i.InvtID = D.InvtID
                       AND i.SiteID = D.SiteID
     WHERE i.InvtID = D.InvtID
       AND i.SiteID = D.SiteID

	UPDATE ItemSite
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
            + PrjINQtyShipNotInv
            + PrjINQtyAllocSO
            + PrjINQtyAllocIN
            + PrjINQtyAllocPORet
            - case when @OptWOFirmRlsedDemand in ('F','R') then QtyWORlsedDemand else 0 End
            - case when @OptWOFirmRlsedDemand = 'F' then S4Future03 else 0 end,
           @QtyPrec)
     WHERE InvtID = @InvtID
       AND SiteID = @SiteID

	-- Recalculate the quantity available if CPS is off.
	IF (@QtyAvailUpdateMode = 0)
	  BEGIN
		exec ADG_Invt_CalcQtyAvail @InvtID, @SiteID, 'PLAN', 'PLAN'
    END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Plan_UpdtInvtOrderQtys] TO [MSDSL]
    AS [dbo];

