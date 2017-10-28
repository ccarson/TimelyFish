CREATE PROC OU_ShipperFrtToApply
	@CpnyID			varchar(10),
	@OrdNbr			varchar(15),
	@ShipperID		varchar(15)
AS
    SET nocount ON

    DECLARE @RcptCuryTotFreight    FLOAT,
            @RcptTotFreight        FLOAT,
            @ShipCuryTotPremFrtAmt FLOAT,
            @ShipTotPremFrtAmt     FLOAT

	-- Get the freight on all PO receipts for the purchase order(s) for the sales order.
    SELECT @RcptCuryTotFreight = Cast(Isnull(Sum(CuryExtCost), 0) AS FLOAT),
           @RcptTotFreight = Cast(Isnull(Sum(ExtCost), 0) AS FLOAT)
    FROM   POTran
    WHERE  PurchaseType = 'FR'
           AND PONbr IN (SELECT DISTINCT PONbr
                         FROM   POAlloc P
                         WHERE  CpnyID = @CpnyID
                                AND SOOrdNbr = @OrdNbr)

	-- Get the premium freight on the shipper(s) for the sales order.
    SELECT @ShipCuryTotPremFrtAmt = Sum(CuryPremFrtAmt),
           @ShipTotPremFrtAmt = Sum (PremFrtAmt)
    FROM   SOShipHeader (nolock)
    WHERE  CpnyID = @CpnyID
           AND OrdNbr = @OrdNbr
           AND Cancelled = 0

	-- Calculate the freight to apply using the previous values and
	-- the currently applied premium freight from the sales order.
    SELECT @RcptCuryTotFreight - CASE
                                   WHEN S4future04 <> 0 THEN ( @ShipCuryTotPremFrtAmt - S4Future04 )
                                   ELSE 0
                                 END CuryFreightToApply,
           @RcptTotFreight - CASE
                               WHEN S4Future05 <> 0 THEN ( @ShipTotPremFrtAmt - S4Future05 )
                               ELSE 0
                             END     FreightToApply
    FROM   SOHeader
    WHERE  CpnyID = @CpnyID
           AND OrdNbr = @OrdNbr 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_ShipperFrtToApply] TO [MSDSL]
    AS [dbo];

