 -- DE 226977 Added new proc called by PR Data entry screens.
CREATE PROC PRDetail_Pricing
	@szServCallID VARCHAR(10),
	@szCustID VARCHAR(15),
	@szShiptoID VARCHAR(10),
	@szInvtID VARCHAR(30),
	@UnitCost float As Declare @UnitPrice float

EXECUTE smTM_Detail_Pricing @szServCallID,
	@szCustID,
	@szShiptoID,
	@szInvtID,
	@UnitCost,
	@UnitPrice OUTPUT

SELECT @UnitPrice



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDetail_Pricing] TO [MSDSL]
    AS [dbo];

