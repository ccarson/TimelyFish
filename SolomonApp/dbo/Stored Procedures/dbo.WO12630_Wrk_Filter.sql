 CREATE PROCEDURE WO12630_Wrk_Filter
   	@RI_ID   	smallint

AS
	Set NOCOUNT ON

	DECLARE
	@InvtID		varchar( 30 ),
	@SiteID		varchar( 10 ),
	@DecPlQty	smallint,
	@CumQty		float,
	@Qty		float,
	@CurrInvtID	varchar( 30 ),
	@CurrSiteID	varchar( 10 ),
	@Delete		bit,
	@Source		varchar( 3 )

	-- Select the decimal places for quantity from INSetup
	SELECT  @DecPlQty = DecPlQty From INSetup (NoLock)

   DECLARE          	WO12630_Wrk_Cursor CURSOR SCROLL LOCAL
   FOR
   SELECT           	InvtID, SiteID, Quantity, Source
   FROM             	WO12630_Wrk
   WHERE		RI_ID = @RI_ID
   ORDER BY		InvtID, SiteID, TxnDate, Source

   if (@@error <> 0) GOTO ABORT

	Open WO12630_Wrk_Cursor
	Fetch Next From WO12630_Wrk_Cursor Into @InvtID, @SiteID, @Qty, @Source
	While (@@Fetch_Status = 0)
		Begin

		SELECT		@CurrInvtid = @InvtID,
				@CurrSiteID = @SiteID
		SELECT		@CumQty = 0

		-- Get intial CumQty - On Hand Qty from ItemSite
		SELECT		@CumQty = Round(QtyOnHand, @DecPlQty)
		FROM		ItemSite
		WHERE		InvtID = @CurrInvtID and
				SiteID = @CurrSiteID

		-- Set delete flag to True - assume all positive PIP
		Select @Delete = 1
		-- Loop thru Working file for this InvtID and SiteID
		While (@@Fetch_Status = 0 and @InvtID = @CurrInvtID and @SiteID = @CurrSiteID)
			Begin

			if @Source = '3MR' or @Source = '2SO'
				-- Demand - reduce PIP
				SELECT @CumQty = Round(@CumQty - @Qty, @DecPlQty)
			else
				-- Supply - increase PIP
				SELECT @CumQty = Round(@CumQty + @Qty, @DecPlQty)

			-- Does PIP ever go negative - if so, then we want to keep
			if Round(@CumQty, @DecPlQty) < 0
				-- Set Delete flag to False
				Select @Delete = 0

			Fetch Next From WO12630_Wrk_Cursor Into @InvtID, @SiteID, @Qty, @Source
			End

		-- If CumQty did not go negative, then remove from file
		if @Delete = 1
			DELETE 	FROM WO12630_Wrk
   			WHERE 	RI_ID = @RI_ID and
   				InvtID = @CurrInvtID and
   				SiteID = @CurrSiteID

		End
	Close WO12630_Wrk_Cursor
	Deallocate WO12630_Wrk_Cursor

ABORT:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WO12630_Wrk_Filter] TO [MSDSL]
    AS [dbo];

