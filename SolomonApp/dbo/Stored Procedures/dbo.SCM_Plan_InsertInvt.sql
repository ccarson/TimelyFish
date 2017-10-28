 CREATE PROCEDURE SCM_Plan_InsertInvt
	@ComputerName	VARCHAR(21),
	@LUpd_Prog	CHAR(8),
	@LUpd_User	CHAR(10)
AS
	SET NOCOUNT ON

	-- Insert inventory plan record if none currently exists
	--
	-- Note that since PlanDate is a key field, we must be very careful about setting
	-- it to a date value only.
	--

	INSERT INTO SOPlan
	(
		InvtID,
		SiteID,
		Crtd_DateTime,
		Crtd_Prog,
		Crtd_User,
		LUpd_DateTime,
		LUpd_Prog,
		LUpd_User,
		PlanDate,
		PlanRef,
		PlanType,
		Qty
	)
	SELECT
		INU.InvtID,
		INU.SiteID,
		GETDATE(),
		@LUpd_Prog,
		@LUpd_User,
		GETDATE(),
		@LUpd_Prog,
		@LUpd_User,
		CAST(FLOOR(CAST(GETDATE() AS FLOAT)) AS SMALLDATETIME),
		'00000',
		'10',
		(	-- This is the algorithm from ADG_Plan_QOH. If it changes, this
			-- needs to be updated to match.
			SELECT	ISNULL(SUM(l.QtyOnHand - l.QtyShipNotInv),0)
			FROM	Location  l
			JOIN	LocTable  lt
	  		ON	lt.SiteID = l.SiteID
			AND	lt.WhseLoc = l.WhseLoc
			WHERE	l.InvtID = INU.InvtID
			AND	l.SiteID = INU.SiteID
			AND	lt.InclQtyAvail = 1)

	FROM 	INUpdateQty_Wrk INU (NOLOCK)
	WHERE	NOT EXISTS
			(SELECT * FROM SOPlan p
			WHERE 	p.InvtID = INU.InvtID
			AND 	p.SiteID = INU.SiteID
			AND 	p.PlanType = '10')
	AND	INU.ComputerName LIKE @ComputerName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_InsertInvt] TO [MSDSL]
    AS [dbo];

