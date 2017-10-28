
CREATE PROCEDURE XDDDepositor_eBank_Status
   @VendCust	varchar(1),
   @VendID	varchar(15),
   @VendAcct	varchar(10),
   @EStatus	varchar(1)		-- value of EStatus for the vendor

AS

   Declare	@AcctAppStatus	varchar( 1 )
   Declare	@ACHeStatus	bit
   Declare	@CurrDate	smalldatetime
   Declare  	@FormatID 	varchar( 15 )
   Declare	@PNStatus	varchar( 1 )
   Declare 	@PNDate		smalldatetime
   Declare 	@PreNotes	smallint
   Declare	@Status		varchar( 1 )
   Declare   	@TermDate	smalldatetime
   Declare	@VStatus	varchar( 1 )
      
   -- 'P' - Warning - Pre-note status is not approved  (only if Pre-Notes and ACH eStatus)
   -- 'I' - Warning - Status is not Active in eBanking (Any eStatus)
   -- 'T' - Warning - Vendor is terminated in eBanking (Any eStatus)
   -- 'A' - Warning - Account is pending approval
   -- 'V' - Warning - Not setup as an eBanking vendor
   -- 'Y' - OK

   Declare	@AcctAppOption	smallint

   -- strip off minutes... so only date portion remains	
   SET		@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)

   -- is eBanking Security being used, if so, is it setup for Acct Number Approval?
   SET		@AcctAppOption = 0
   SELECT	@AcctAppOption = ModeBankSecurity
   FROM		XDDSetup (nolock)

   if @AcctAppOption = 1   	
      	SELECT	@AcctAppOption = AcctApp
      	FROM	XDDSetupEX (nolock)

   -- Determine if this eStatus is an ACH eStatus (might involve Prenotes)
   -- IMPORTANT:
   -- eStatus's 0-6 are reserved for eBanking ACH eStatuses
   -- SET		@ACHeStatus = 0
   -- if @Estatus <> ' ' and CHARINDEX(@EStatus, '0123456') > 0
   --	SET @ACHeStatus = 1
   
   SET	@Status = 'Y'

   if @EStatus <> ' '
   BEGIN 

	   if exists(Select * from XDDDepositor (nolock) where VendCust = @VendCust and VendID = @VendID and VendAcct = @VendAcct)
	   BEGIN
		   SELECT 	@FormatID = D.FormatID,
		   		@PNStatus = D.PNStatus,
		   		@PNDate = D.PNDate,
		   		@VStatus = D.Status,
		   		@TermDate = D.TermDate,
		   		@PreNotes = case when F.PreNote = 1	-- Format AND TxnType w/in Format must support PreNotes
		   			then coalesce(T.TxnPreNote, 0)
		   			else coalesce(F.PreNote, 0)
		   			end,
		   		@AcctAppStatus = D.AcctAppStatus
		   FROM		XDDDepositor D (nolock) LEFT OUTER JOIN XDDFileFormat F (nolock)
		   		ON D.FormatID = F.FormatID LEFT OUTER JOIN XDDTxnType T (nolock)
		   		ON D.FormatID = T.FormatID and T.EStatus = @EStatus and T.Selected = 'Y'
		   WHERE	D.VendCust = @VendCust
		   		and D.VendID = @VendID
				and D.VendAcct = @VendAcct
	
		   -- Using PreNotes (could be a Wire ACH txn using prenotes)
		   if @PreNotes = 1 -- and @ACHeStatus = 1
		   	if @PNStatus = 'N' or (@PNStatus = 'P' and @PNDate > @CurrDate)
		   		SET @Status = 'P'
	
		   -- Is Vendor eBanking Active?
		   if @VStatus <> 'Y'
		   		SET @Status = 'I'
	
		   -- Is Vendor eBanking Terminated?
		   if @TermDate <> convert(smalldatetime, '01/01/1900') and @TermDate <= @CurrDate
		   		SET @Status = 'T'

		   -- Is Account still Pending?
		   If @AcctAppOption <> 0 and @AcctAppStatus = 'P'
   				SET @Status = 'A'
   				
	   END
	
	   else
	   
	   BEGIN
		-- Not an eBanking Vendor, but setting the APDoc.eStatus to an eBanking Txn Type
   		SET	@Status = 'V'
	   END
   END
   
   -- Return the status code
   SELECT	@Status


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_eBank_Status] TO [MSDSL]
    AS [dbo];

