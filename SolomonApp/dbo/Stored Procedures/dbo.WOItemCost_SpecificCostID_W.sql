 CREATE PROCEDURE WOItemCost_SpecificCostID_W
   	@WONbr   	varchar( 16 )

AS
	Set NOCOUNT ON

	DECLARE
	@InvtID		varchar( 30 ),
	@SiteID		varchar( 10 ),
	@OrdNbr		char( 15 ),		-- use char not varchar so full width is used
	@BuildToLineRef	varchar( 5 ),
	@Cost		float,
	@TotCost	float,
	@DecPlPrcCst	smallint

	-- Select the decimal places for cost total from INSetup
	SELECT  @DecPlPrcCst = DecPlPrcCst From INSetup

	SELECT @TotCost	= 0

   DECLARE          	WOBuildTo_Cursor CURSOR LOCAL
   FOR
   SELECT           	InvtID, SiteID, OrdNbr, BuildToLineRef
   FROM             	WOBuildTo
   WHERE            	WONbr = @WONbr
   			and Status = 'P'
			and BuildToType = 'ORD'
   if (@@error <> 0) GOTO ABORT

	Open WOBuildTo_Cursor
	Fetch Next From WOBuildTo_Cursor Into @InvtID, @SiteID, @OrdNbr, @BuildToLineRef
	While (@@Fetch_Status = 0)
		Begin

			SELECT		@Cost = Sum(Round(TotCost, @DecPlPrcCst))
			FROM		ItemCost
			WHERE		SpecificCostID = @OrdNbr + @BuildToLineRef and
					InvtID = @InvtID and
					SiteID = @SiteID and
					LayerType = 'W'
			GROUP BY	InvtID, SiteID, LayerType, SpecificCostID

			SELECT		@TotCost = Round(@TotCost + @Cost, @DecPlPrcCst)

			Fetch Next From WOBuildTo_Cursor Into @InvtID, @SiteID, @OrdNbr, @BuildToLineRef
		End
	Close WOBuildTo_Cursor
	Deallocate WOBuildTo_Cursor

ABORT:

SELECT @TotCost TotCost
RETURN

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


