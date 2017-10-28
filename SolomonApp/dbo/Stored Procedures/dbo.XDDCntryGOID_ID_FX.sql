
CREATE PROCEDURE XDDCntryGOID_ID_FX
	@CpnyID		varchar( 10 ),
	@Acct 		varchar( 10 ),
	@Sub 		varchar( 24 ),
	@ISOCntry		varchar( 2 )
AS
	Select 		GatewayOperID, DestCntryCuryID, FXIndicator
  	from 		XDDCntryGOID (nolock)
  	where 		CpnyID = @CpnyID
  				and Acct = @Acct
  				and Sub = @Sub
  				and ISOCntry = @ISOCntry
