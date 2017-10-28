
CREATE PROCEDURE XDDCntryGOID_All
	@CpnyID		varchar( 10 ),
	@Acct 		varchar( 10 ),
	@Sub 		varchar( 24 ),
	@ISOCntry		varchar( 2 )
AS
  	Select 		*
  	from 		XDDCntryGOID
  	where 		CpnyID LIKE @CpnyID
  				and Acct like @Acct
  				and Sub like @Sub
  				and ISOCntry like @ISOCntry
  	ORDER by 		CpnyID, Acct, Sub, ISOCntry
