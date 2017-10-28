 CREATE PROCEDURE Integrity_Balance_QtyCost
	@InvtID		VarChar(30),
	@BMILastCost	Float,
	@BMIStdCost	Float,
	@LastCost	Float,
	@LotSerTrack	Char(2),
	@SerAssign	Char(1),
	@StdCost	Float,
	@ValMthd	Char(1),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt,
	@LUpd_Prog	VARCHAR(8),
	@LUpd_User	VARCHAR(10),
	@NegQty		SMALLINT,
	@MatlOvhCalc	CHAR(1),
	@BMIEnabled	BIT
AS

SET	NOCOUNT ON

/*
	Clear all Insufficient Quantity and Quantity UnCosted values from INTran.
*/
UPDATE	INTran
	SET	InsuffQty = 0,
		QtyUncosted = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID

/*
	Deletes any LotSerMst records that shouldn't exist for valid items that aren't Lot/Serial Controlled.
*/
DELETE	FROM	LotSerMst
	WHERE	LotSerMst.InvtID = @InvtID
		And @LotSerTrack NOT IN ('LI', 'SI')
/*
	Delete any bad Site combination records.
*/
DELETE	FROM Location
	FROM	Location LEFT JOIN Site (NoLock)
		ON Location.SiteID = Site.SiteID
	WHERE	Site.SiteID IS NULL
		AND Location.InvtID = @InvtID

DELETE	FROM LotSerMst
	FROM	LotSerMst LEFT JOIN Site (NoLock)
		ON LotSerMst.SiteID = Site.SiteID
	WHERE	Site.SiteID IS NULL
		AND LotSerMst.InvtID = @InvtID

DELETE	FROM ItemSite
	FROM	ItemSite LEFT JOIN Site (NoLock)
		ON ItemSite.SiteID = Site.SiteID
	WHERE	Site.SiteID IS NULL
		AND ItemSite.InvtID = @InvtID
	Delete	From	ItemCost
	Where	Round(Qty, @DecPlQty) = 0
		And InvtID = @InvtID

/*
	Sets the quantity on hand to zero for a Lot/Serial assigned 'When Used'.
*/
UPDATE	LotSerMst
	SET	QtyOnHand = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		And @LotSerTrack IN ('LI', 'SI')
		AND @SerAssign = 'U'

/*
	Sets the quantity on hand to zero for any Lot/Serial assigned 'When Received' and quantity on hand is negative.
*/
UPDATE	LotSerMst
	SET	QtyOnHand = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(QtyOnHand, @DecPlQty) < 0
		And @LotSerTrack IN ('LI', 'SI')
		AND @SerAssign = 'R'

/*
	Sets the quantity on hand to one (1) for any Serial assigned 'When Received' and quantity on hand is greater than 1.
*/
UPDATE	LotSerMst
	SET	QtyOnHand = 1,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(QtyOnHand, @DecPlQty) >= 1
		And @LotSerTrack IN ('SI')
		AND @SerAssign = 'R'

/*
	Sets the quantity on hand to ZERO (0) for any Serial assigned 'When Received' and quantity on hand is LESS than 1.
*/
UPDATE	LotSerMst
	SET	QtyOnHand = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(QtyOnHand, @DecPlQty) < 1
		And @LotSerTrack IN ('SI')
		AND @SerAssign = 'R'

/*
	Update the LayerType field in ItemCost with 'S' if it is blank.
*/
UPDATE	ItemCost
	SET	LayerType = 'S',
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	DATALENGTH(RTRIM(LayerType)) = 0
		AND InvtID = @InvtID

Update	ItemCost
	Set	TotCost = Round(Abs(Round(TotCost, @BaseDecPl))
		* Case When Round(Qty, @DecPlQty) < 0 Then -1 Else 1 End, @BaseDecPl),
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	Where	InvtID = @InvtID

Update	ItemCost
	Set	UnitCost = Round(TotCost / Qty, @DecPlPrcCst),
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	Where	InvtID = @InvtID

/*
	Remove any ItemCost records that are not for layered valuation methods, or where created by MWO.
*/
Delete	From	ItemCost
	Where	InvtID = @InvtID
		And (LayerType = 'W'
		Or @ValMthd NOT IN ('F', 'L', 'S'))

/*
	Zero quantity on hand for Item at all Sites.
*/
UPDATE	ItemSite
	SET	QtyOnHand = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID

/*
	Set Location quantity on hand to ZERO for all Lot/Serial assigned When Received.
*/
UPDATE	Location
	SET	QtyOnHand = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		And @LotSerTrack IN ('LI', 'SI')
		AND @SerAssign = 'R'

/*
	Set Location quantity on hand equal to the sum of all LotSerMst records.
*/
UPDATE	Location
	SET	Location.QtyOnHand =
		ISNULL((SELECT ROUND(SUM(ROUND(LotSerMst.QtyOnHand, @DecPlQty)), @DecPlQty)
				FROM	LotSerMst (NoLock)
				WHERE	LotSerMst.InvtID = Location.InvtID
					AND LotSerMst.SiteID = Location.SiteID
					AND LotSerMst.WhseLoc = Location.WhseLoc
				GROUP BY LotSerMst.InvtID, LotSerMst.SiteID, LotSerMst.WhseLoc), 0),
		Location.LUpd_DateTime = GETDATE(),
		Location.LUpd_Prog = @LUpd_Prog,
		Location.LUpd_User = @LUpd_User
	WHERE	Location.InvtID = @InvtID
		And @SerAssign = 'R'
		AND @LotSerTrack IN ('LI', 'SI')

/*
	Set ItemSite quantity on hand equal to the sum of all Location records.
*/
UPDATE	ItemSite
	SET	ItemSite.QtyOnHand =
		ISNULL((SELECT ROUND(SUM(ROUND(Location.QtyOnHand, @DecPlQty)), @DecPlQty)
				FROM 	Location (NoLock)
				WHERE	Location.InvtID = ItemSite.InvtID
					AND Location.SiteID = ItemSite.SiteID
					GROUP BY Location.InvtID, Location.SiteID), 0),
		ItemSite.LUpd_DateTime = GETDATE(),
		ItemSite.LUpd_Prog = @LUpd_Prog,
		ItemSite.LUpd_User = @LUpd_User
	FROM	ItemSite Inner Join Site (NoLock)
		ON Site.SiteID = ItemSite.SiteID
	WHERE	ItemSite.InvtID = @InvtID

/*
	Set ItemSite quantity on hand equal to ZERO when valuation method is Specific Cost ID and quantity on hand
	is less than ZERO.
*/
UPDATE	ItemSite
	SET	QtyOnHand = 0,
		AvgCost = 0,
		BMIAvgCost = 0,
		TotCost = 0,
		BMITotCost = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		And ((QtyOnHand < 0
		AND (@ValMthd = 'S'
		OR @NegQty = 0))
		OR QtyOnHand = 0)

/*
	Zero the quantity on hand for all Locations where their sum equals zero.
*/
UPDATE	Location
	SET	Location.QtyOnHand = 0,
		Location.LUpd_DateTime = GETDATE(),
		Location.LUpd_Prog = @LUpd_Prog,
		Location.LUpd_User = @LUpd_User
	FROM	ItemSite JOIN Location
		ON ItemSite.InvtID = Location.InvtID
		AND ItemSite.SiteID = Location.SiteID
	WHERE	ItemSite.QtyOnHand = 0
		AND ItemSite.InvtID = @InvtID

/*
	Remove any ItemCost records when ItemSite quantity on hand equals ZERO.
*/
DELETE	FROM	ItemCost
	FROM	ItemCost JOIN ItemSite
		ON ItemCost.InvtID = ItemSite.InvtID
		AND ItemCost.SiteID = ItemSite.SiteID
	WHERE	ItemSite.QtyOnHand = 0
		AND ItemCost.InvtID = @InvtID

/*
	Remove any ItemCost records when ItemSite quantity on hand is greater than zero and
	ItemCost quantity is less than or equal to zero.
*/
DELETE	FROM	ItemCost
	FROM	ItemCost Inner Join ItemSite (NoLock)
		ON ItemCost.InvtID = ItemSite.InvtID
		AND ItemCost.SiteID = ItemSite.SiteID
	WHERE	ROUND(ItemSite.QtyOnHand, @DecPlQty) > 0
		AND ROUND(ItemCost.Qty, @DecPlQty) <= 0
		AND ItemCost.InvtID = @InvtID
/*
	Update the average cost (AvgCost/BMIAvgCost) for Average Cost Valuation Method items WHEN quantity on hand is zero.
*/
UPDATE	ItemSite
	SET	AvgCost = 0,
		TotCost = 0,
		BMIAvgCost = 0,
		BMITotCost = 0
	WHERE	InvtID = @InvtID
		AND ROUND(QtyOnHand, @DecPlQty) = 0
		And @ValMthd = 'A'

/*
	Set UNIT costs and total costs to ZERO when Inventory valuation method is User Specified Cost.
*/
UPDATE	ItemSite
	SET	AvgCost = 0,
		BMIAvgCost = 0,
		TotCost = 0,
		BMITotCost = 0,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		And @ValMthd = 'U'

/*
	Update total cost (TotCost/BMITotCost) for Standard cost items.
*/
UPDATE	ItemSite
	SET	TotCost =	CASE	WHEN @MatlOvhCalc = 'U' THEN ROUND(QtyOnHand * DirStdCst, @BaseDecPl)
						WHEN @MatlOvhCalc = 'R' THEN ROUND(QtyOnHand * StdCost, @BaseDecPl)
						ELSE ROUND(QtyOnHand * DirStdCst, @BaseDecPl)
					END,
		BMITotCost = 	CASE	WHEN @BMIEnabled = 0	THEN 0
						WHEN @MatlOvhCalc = 'U' THEN ROUND(QtyOnHand * BMIDirStdCst, @BMIDecPl)
						WHEN @MatlOvhCalc = 'R' THEN ROUND(QtyOnHand * BMIStdCost, @BMIDecPl)
						ELSE ROUND(QtyOnHand * BMIDirStdCst, @BMIDecPl)
					END,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		And @ValMthd = 'T'

/*
	Update the average cost (AvgCost/BMIAvgCost) for non-User Specified valuation types.
*/
UPDATE	ItemSite
	SET	AvgCost = ROUND(ROUND(TotCost, @BaseDecPl) / ROUND(QtyOnHand, @DecPlQty), @DecPlPrcCst),
		BMIAvgCost = CASE WHEN @BMIEnabled = 0 THEN 0 ELSE ROUND(ROUND(BMITotCost, @BMIDecPl) / ROUND(QtyOnHand, @DecPlQty), @DecPlPrcCst) END,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(TotCost, @BaseDecPl) > 0
		And @ValMthd <> 'U'

/*
	Update the average cost (AvgCost/BMIAvgCost) for non-User Specified, non-Standard Cost valuation types.
*/
UPDATE	ItemSite
	SET	AvgCost =	CASE	WHEN ROUND(QtyOnHand, @DecPlQty) = 0
						THEN 0
					WHEN ROUND(LastCost, @DecPlPrcCst) > 0
						THEN ROUND(LastCost, @DecPlPrcCst)
					WHEN ROUND(StdCost, @DecPlPrcCst) > 0
						THEN ROUND(StdCost, @DecPlPrcCst)
					WHEN ROUND(@LastCost, @DecPlPrcCst) > 0
						THEN ROUND(@LastCost, @DecPlPrcCst)
					WHEN ROUND(@StdCost, @DecPlPrcCst) > 0
						THEN ROUND(@StdCost, @DecPlPrcCst)
					ELSE 0
				END,
		BMIAvgCost =	CASE	WHEN ROUND(QtyOnHand, @DecPlQty) = 0
						THEN 0
					WHEN @BMIEnabled = 0
						THEN 0
					WHEN ROUND(BMILastCost, @DecPlPrcCst) > 0
						THEN ROUND(BMILastCost, @DecPlPrcCst)
					WHEN ROUND(BMIStdCost, @DecPlPrcCst) > 0
						THEN ROUND(BMIStdCost, @DecPlPrcCst)
					WHEN ROUND(@BMILastCost, @DecPlPrcCst) > 0
						THEN ROUND(@BMILastCost, @DecPlPrcCst)
					WHEN ROUND(@BMIStdCost, @DecPlPrcCst) > 0
						THEN ROUND(@BMIStdCost, @DecPlPrcCst)
					ELSE 0
				END,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(TotCost, @BaseDecPl) <= 0
		And @ValMthd NOT IN ('U', 'T')

/*
	Update the average cost (AvgCost/BMIAvgCost) for Average Cost Valuation Method items.
*/
UPDATE	ItemSite
	SET	TotCost = ROUND(ROUND(AvgCost, @DecPlPrcCst) * ROUND(QtyOnHand, @DecPlQty), @BaseDecPl),
		BMITotCost = CASE WHEN @BMIEnabled = 0 THEN 0 ELSE ROUND(ROUND(BMIAvgCost, @DecPlPrcCst) * ROUND(QtyOnHand, @DecPlQty), @BMIDecPl) END,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	WHERE	InvtID = @InvtID
		AND ROUND(TotCost, @BaseDecPl) <= 0
		AND ROUND(QtyOnHand, @DecPlQty) <> 0
		And @ValMthd = 'A'

/*
	Remove any ItemCost records when ItemSite quantity on hand is less than zero and
	ItemCost quantity is greater than or equal to zero.
*/
DELETE	FROM	ItemCost
	FROM	ItemCost Inner Join ItemSite (NoLock)
		ON ItemCost.InvtID = ItemSite.InvtID
		AND ItemCost.SiteID = ItemSite.SiteID
	WHERE	ItemCost.InvtID = @InvtID
		And Round(ItemSite.QtyOnHand, @DecPlQty) < 0
		AND Round(ItemCost.Qty, @DecPlQty) >= 0

/*
	Remove any ItemCost records when ItemSite quantity on hand is less than zero and
	ItemCost quantity is greater than or equal to zero.
*/
DELETE	FROM	ItemCost
	WHERE	ItemCost.InvtID = @InvtID
		And EXISTS	(SELECT	IC.InvtID, IC.SiteID
					FROM	ItemCost IC Inner Join ItemSite (NoLock)
						ON IC.InvtID = ItemSite.InvtID
						AND IC.SiteID = ItemSite.SiteID
					WHERE	IC.InvtID = ItemCost.InvtID
						AND IC.SiteID = ItemCost.SiteID
						And Round(ItemSite.QtyOnHand, @DecPlQty) < 0
					GROUP BY IC.InvtID, IC.SiteID
					HAVING COUNT(*) > 1)

/*
	Delete any orphan ItemCost records.
*/

DELETE	FROM ItemCost
	FROM 	ItemCost LEFT JOIN ItemSite (NoLock)
		ON ItemCost.InvtID = ItemSite.InvtID
		AND ItemCost.SiteID = ItemSite.SiteID
	WHERE	ItemSite.InvtID IS NULL
		AND ItemCost.InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Integrity_Balance_QtyCost] TO [MSDSL]
    AS [dbo];

