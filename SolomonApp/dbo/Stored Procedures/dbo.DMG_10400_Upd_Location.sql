 CREATE Procedure DMG_10400_Upd_Location
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@DecPlQty		SmallInt,
	@DecPlPrcCst		SmallInt,
	@NegQty			Bit,
	/*End Process Parameter Group*/
	/*Begin Primary Key Parameter Group*/
	@InvtID			Varchar(30),
	@SiteID			Varchar(10),
	@WhseLoc		Char(10),
	/*End Primary Key Parameter Group*/
	/*Begin Update Values Parameter Group*/
	@QtyOnHand		Float,
	@AllocBucket		SmallInt,
        @RcptNbr        VarChar(15),
        @LineRef        VarChar(5),
        @RefNbr         VarChar(15)

	/*End Update Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the quantity on hand (QTYONHAND) and quantity shipped
	not invoiced for the record matching the primary key fields passed as parameters.
	The primary key fields in the Location table define a specific warehouse storage
	location.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare @PurchaseType VarChar(2)  --Project Allocated Inventory Check
	Declare @QtyOnProjInv Float
	Declare @RcptType Varchar(2)
    Declare @SrcNbr VarChar(15)

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

    Declare @QtyRemainToIssue Int,
            @ProjectID As Varchar (15),
            @TaskId As VarChar (32),
            @Qty As Int,
	    @TranType As VarChar(2)
 Select @QtyRemainToIssue = 0,
           @Qty = 0,
           @ProjectID = '',
           @TaskID = '',
	   @TranType = ''

	Execute	@ReturnStatus = DMG_Insert_Location	@InvtID, @SiteID, @Whseloc, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Location', @SQLErrNbr, 3,
				@InvtID, @SiteID, @Whseloc)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Location', @SQLErrNbr, 3,
				@InvtID, @SiteID, @Whseloc)
		Goto Abort
	End
	/*
	Quantity on hand will be passed in positive and negative.  If quantity on hand
	is increasing, the system should not return an error message because a quantity
	can be received into the warehouse bin location that does not completely offset
	the negative on hand quantity.  Also, the system should not fail if the quantity
	on hand value in the quantity on hand (@QTYONHAND) parameter is equal to zero. A
	zero quantity on hand (@QTYONHAND) parameter may occur when when only the quantity
	shipped not invoice (QTYSHIPNOTINV) is to be updated.
	*/
	If @NegQty = @False And Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
	Begin
		If (	Select	Round(CONVERT(DEC(25,9),QtyOnHand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
				From	Location
				Where	InvtID = @InvtID
					And SiteID = @SiteID
					And WhseLoc = @WhseLoc) < 0
		Begin
		/*
		Solomon Error Message
		*/
			Insert 	Into IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
					Parm00, Parm01, Parm02)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_Location', 16081, 3,
					@InvtID, @SiteID, @Whseloc)
			Goto Abort
		End
	End
	/*
	Update the warehouse location quantity on hand and the quantity shipped not invoiced.
	*/
If @RcptNbr = ' ' 
  BEGIN
       Select @SrcNbr = i.SrcNbr, @ProjectID = i.ProjectID, @TaskID = i.TaskID, @Qty = i.Qty,
		@TranType = i.TranType
            FROM Intran i
        Where i.RefNbr = @RefNbr AND i.LineRef = @LineRef AND i.BatNbr = @BatNbr 
        Update	Location
		Set	QtyOnHand = Round(CONVERT(DEC(25,9),QtyOnHand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty),
			QtyAllocBM =	Case	When @AllocBucket <> 1 Then QtyAllocBM Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocBM), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocBM), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocIN =	Case	When @AllocBucket <> 2 Then QtyAllocIN Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocPORet =	Case	When @AllocBucket <> 3 Then QtyAllocPORet Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocPORet), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocPORet), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocSD =	Case	When @AllocBucket <> 4 Then QtyAllocSD Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocSD), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocSD), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyShipNotInv =	Case	When @AllocBucket <> 6 Then QtyShipNotInv Else
					Case	When Round(CONVERT(DEC(25,9),QtyShipNotInv), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyShipNotInv), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyWORlsedDemand =	Case	When @AllocBucket <> 8 Then QtyWORlsedDemand Else
					Case	When Round(CONVERT(DEC(25,9),QtyWORlsedDemand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyWORlsedDemand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAvail =	Case When @SrcNbr = '' or @AllocBucket <> 0 Or Not Exists (Select * From LocTable Where LocTable.SiteId = Location.SiteId And LocTable.WhseLoc = Location.WhseLoc And LocTable.InclQtyAvail = 1)
						Then QtyAvail  Else
						Round(CONVERT(DEC(25,9),QtyAvail), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End,
           		QtyAllocProjIN = CASE WHEN @SrcNbr <> '' Then
						Round(CONVERT(DEC(25,9),QtyAllocProjIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					 ELSE CASE WHEN @TranType = 'RP' Then
							Round(CONVERT(DEC(25,9),QtyAllocProjIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty)
						ELSE QtyAllocProjIN END
					End,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And WhseLoc = @WhseLoc


          UPDATE Location
             SET PrjINQtyAllocIN = COALESCE(D.PrjINQtyAllocIN,0)
            FROM Location LEFT JOIN (SELECT i.InvtID,
                                             i.SiteID,
                                             i.WhseLoc,
                                             SUM(i.QtyAllocated) as PrjINQtyAllocIN
                                        FROM INPrjAllocation i JOIN INTran t
                                                                 ON i.SrcNbr = t.RefNbr
                                                                AND i.SrcLineRef = t.LineRef
                                                                AND i.InvtID = t.InvtID
                                                                AND i.SiteID = t.SiteID
                                       WHERE i.InvtID = @InvtID
                                         AND i.SiteID = @SiteID
                                         AND i.WhseLoc = @Whseloc
                                         AND i.SrcType = 'IS'
                                         AND t.Rlsed = 0
                                         AND t.TranType = 'II'      
                                       GROUP BY i.InvtID, i.SiteID, i.WhseLoc) as D

                            ON D.InvtID = Location.InvtID
                           AND	D.SiteID = Location.SiteID
                           AND	D.WhseLoc = Location.WhseLoc

          WHERE Location.InvtID = @InvtID
            AND Location.SiteID = @SiteID
            AND Location.WhseLoc = @WhseLoc
            AND EXISTS(SELECT *
				         FROM Loctable l
				        WHERE l.SiteID = Location.SiteID
				          AND l.WhseLoc = Location.Whseloc
				          AND l.InclQtyAvail = 1)

END
ELSE
BEGIN
   -- Check for Project Allocated Inventory, and update the Project Allocated Inventory Bucket and don't update QtyAvail.
   -- @QtyOnProjInv - Project Allocated inventory that has been unallocated, so we need to only remove the Project Allocated Inventory that is remaining for a return of a purchase order.
   SELECT @PurchaseType = p.PurchaseType, @RcptType = p.TranType, @QtyOnProjInv = ISNULL(h.Quantity,0)
     FROM POTran p  LEFT JOIN (SELECT i.TranSrcNbr, i.TranSrcLineRef, SUM(i.Quantity) Quantity
                                FROM INPrjAllocTranHist i WITH(NOLOCK) 
                               WHERE i.TranSrcNbr = @RefNbr 
                                 AND i.TranSrcLineRef  = @LineRef
                                 AND i.TranSrcType = 'RFR'
                               Group by i.TranSrcNbr, i.TranSrcLineRef) AS h
                           ON p.RcptNbr = h.TranSrcNbr
                          AND p.LineRef = h.TranSrcLineRef
                          AND p.PurchaseType IN ('PI','PS')
    WHERE p.RcptNbr = @RefNbr AND p.LineRef = @LineRef   --(For a Return - RefNbr = Return RcptNbr and RcptNbr = Original Receipt Nbr) (For a Receipt - RefNbr and RcptNbr contain POTran.RcptNbr) 
     
	Update	Location
		Set	QtyOnHand = Round(CONVERT(DEC(25,9),QtyOnHand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty),
			QtyAllocBM =	Case	When @AllocBucket <> 1 Then QtyAllocBM Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocBM), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocBM), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocIN =	Case	When @AllocBucket <> 2 Then QtyAllocIN Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocIN), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocPORet =	Case	When @AllocBucket <> 3 Then QtyAllocPORet Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocPORet), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocPORet), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAllocSD =	Case	When @AllocBucket <> 4 Then QtyAllocSD Else
					Case	When Round(CONVERT(DEC(25,9),QtyAllocSD), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyAllocSD), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyShipNotInv =	Case	When @AllocBucket <> 6 Then QtyShipNotInv Else
					Case	When Round(CONVERT(DEC(25,9),QtyShipNotInv), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyShipNotInv), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyWORlsedDemand =	Case	When @AllocBucket <> 8 Then QtyWORlsedDemand Else
					Case	When Round(CONVERT(DEC(25,9),QtyWORlsedDemand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty) < 0
							Then 0
						Else Round(CONVERT(DEC(25,9),QtyWORlsedDemand), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
					End End,
			QtyAvail =	CASE WHEN @AllocBucket <> 0 Or Not Exists (Select * From LocTable Where LocTable.SiteId = Location.SiteId And LocTable.WhseLoc = Location.WhseLoc And LocTable.InclQtyAvail = 1)
						     THEN QtyAvail
                             ELSE CASE WHEN @PurchaseType IN ('PI','PS')
                                       THEN CASE WHEN @RcptType = 'X' AND @QtyOnProjInv < 0 AND @QtyOnHand <> @QtyOnProjInv -- Need to take out Project Allocated Inventory that was unallocated.
                                                  THEN Round(CONVERT(DEC(25,9),QtyAvail), @DecPlQty) + (Round(CONVERT(DEC(25,9),@QtyOnHand) + (CONVERT(DEC(25,9),@QtyOnProjInv) * -1), @DecPlQty))
                                                  ELSE QtyAvail
                                            END
						               ELSE Round(CONVERT(DEC(25,9),QtyAvail), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyOnHand), @DecPlQty)
                                  END
					    END,
			QtyAllocProjIN = CASE WHEN @PurchaseType IN ('PI','PS') 
                                  THEN CASE WHEN @RcptType = 'X' 
                                             THEN CASE WHEN @QtyOnProjInv < 0 -- Need to take out Project Allocated Inventory that was unallocated.
                                                         THEN Round(CONVERT(DEC(25,9),QtyAllocProjIN), 0) + Round(CONVERT(DEC(25,9),@QtyOnProjInv), 0)
                                                       ELSE QtyAllocProjIN
                                                         END 
                                             ELSE Round(CONVERT(DEC(25,9),QtyAllocProjIN), 0) + Round(CONVERT(DEC(25,9),@QtyOnHand), 0)
                                        END
                                  ELSE QtyAllocProjIN END,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And WhseLoc = @WhseLoc
			
		UPDATE Location
           SET PrjINQtyAllocPORet = COALESCE(D.PrjINQtyAllocPORet,0)
          FROM Location LEFT JOIN (SELECT i.InvtID,
                                          i.SiteID,
                                          i.WhseLoc,
                                          SUM(i.QtyAllocated) as PrjINQtyAllocPORet
                                     FROM INPrjAllocation i JOIN INTran t
                                                              ON i.SrcNbr = t.RefNbr
                                                             AND i.SrcLineRef = t.LineRef
                                                             AND i.InvtID = t.InvtID
                                                             AND i.SiteID = t.SiteID
                                                             AND i.WhseLoc = t.WhseLoc
                                    WHERE i.InvtID = @InvtID
                                      AND i.SiteID = @SiteID
                                      AND i.WhseLoc = @Whseloc
                                      AND i.SrcType = 'RN'
                                      AND t.Rlsed = 0
                                      AND t.TranType = 'II'      
                                    GROUP BY i.InvtID, i.SiteID, i.WhseLoc) as D

                         ON D.InvtID = Location.InvtID
                        AND	D.SiteID = Location.SiteID
                        AND	D.WhseLoc = Location.WhseLoc

         WHERE Location.InvtID = @InvtID
           AND Location.SiteID = @SiteID
           AND Location.WhseLoc = @WhseLoc
           AND EXISTS(SELECT *
				        FROM Loctable l
				       WHERE l.SiteID = Location.SiteID
				         AND l.WhseLoc = Location.Whseloc
				         AND l.InclQtyAvail = 1)

END

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Location', @SQLErrNbr, 3,
				@InvtID, @SiteID, @Whseloc)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


