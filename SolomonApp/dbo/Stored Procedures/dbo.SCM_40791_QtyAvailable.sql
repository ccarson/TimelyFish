 CREATE PROCEDURE SCM_40791_QtyAvailable
	@InvtID			varchar( 30 ),
	@SiteID			varchar( 10 ),
	@LeadTimeDate		smalldatetime
AS

	DECLARE			@QtyNet 	float
	DECLARE			@QtyOnHand	float
	DECLARE			@DecPlQty	smallint
	DECLARE			@IS_SiteID	varchar( 10 )
	DECLARE			@QtySOPlan	float
	DECLARE			@QtyTotal	float

	SELECT			@DecPlQty = DecPlQty
	FROM			INSetup (nolock)

	if @SiteID = '%'
		-- Check if Any Site has a negative balance
		BEGIN

		-- Cursor cycles thru each possible Site for this Item
		DECLARE         ItemSite_Cursor CURSOR LOCAL
   		FOR
   		SELECT          SiteID
   		FROM            ItemSite (nolock)
   		WHERE		InvtID = @InvtID
   		ORDER BY	InvtID, SiteID

		if (@@error <> 0) GOTO ABORT

		Open ItemSite_Cursor
		Fetch Next From ItemSite_Cursor Into @IS_SiteID
		While (@@Fetch_Status = 0)
			BEGIN

			SELECT		@QtyOnHand = 0
			SELECT		@QtyNet = 0

			SELECT		@QtyOnHand = Round(Qty, @DecPlQty)
			FROM		SOPlan (nolock)
			WHERE		Invtid = @InvtID
					and SiteID = @IS_SiteID
					and PlanType = '10'

			-- Cursor cycles thru SOPlan - checking if QtyAvail goes negative
			DECLARE         SOPlan_Cursor CURSOR LOCAL
	   		FOR
	   		SELECT          Qty
	   		FROM            SOPlan (nolock)
	   		WHERE		InvtID = @InvtID
	   				and SiteID = @IS_SiteID
	   				and PlanType <> '10'
	   		ORDER BY	InvtID, SiteID, PlanDate, PlanType

			if (@@error <> 0) GOTO ABORT

			Open SOPlan_Cursor
			Fetch Next From SOPlan_Cursor Into @QtySOPlan
			While (@@Fetch_Status = 0)
				BEGIN
				SELECT	@QtyNet = Round(@QtyNet + @QtySOPLan, @DecPlQty)

				if Round(@QtyOnHand + @QtyNet, @DecPlQty) < 0
					BEGIN
					Close SOPlan_Cursor
					Deallocate SOPlan_Cursor
					GOTO FINISH
					END

				Fetch Next From SOPlan_Cursor Into @QtySOPlan
				END

			Close SOPlan_Cursor
			Deallocate SOPlan_Cursor

			Fetch Next From ItemSite_Cursor Into @IS_SiteID
			END

		END
	else
		-- One Site
		BEGIN

		SELECT		@QtyOnHand = 0
		SELECT		@QtyNet = 0

		SELECT		@QtyOnHand = Round(Qty, @DecPlQty)
		FROM		SOPlan (nolock)
		WHERE		Invtid = @InvtID
				and SiteID = @SiteID
				and PlanType = '10'

		-- Cursor cycles thru SOPlan - checking if QtyAvail goes negative
		DECLARE         SOPlan_Cursor CURSOR LOCAL
   		FOR
   		SELECT          Qty
   		FROM            SOPlan (nolock)
   		WHERE		InvtID = @InvtID
   				and SiteID = @SiteID
   				and PlanType <> '10'
   		ORDER BY	InvtID, SiteID, PlanDate, PlanType

		if (@@error <> 0) GOTO ABORT

		Open SOPlan_Cursor
		Fetch Next From SOPlan_Cursor Into @QtySOPlan
		While (@@Fetch_Status = 0)
			BEGIN
			SELECT	@QtyNet = Round(@QtyNet + @QtySOPLan, @DecPlQty)

			if Round(@QtyOnHand + @QtyNet, @DecPlQty) < 0
				GOTO FINISH

			Fetch Next From SOPlan_Cursor Into @QtySOPlan
			END

		Close SOPlan_Cursor
		Deallocate SOPlan_Cursor

		END

ABORT:

FINISH:

	if @SiteID = '%'
		BEGIN
		Close ItemSite_Cursor
		Deallocate ItemSite_Cursor
		END

	SELECT		Round(@QtyOnHand + @QtyNet, @DecPlQty)


