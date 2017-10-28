CREATE PROCEDURE XDDDepositor_TxnTypeDep_PN
	@VendCust	varchar( 1 ),
	@PNStatus	varchar( 1 ),
	@FormatID	varchar( 15 ),		-- format of depositor
	@FormatID_Bat	varchar( 15 )		-- format of batch (could be US-ACH batch, but want Wire depositors)

AS

	-- Check for PNStatus, but must check in XDDTxnTypeDep
  	Select 		*
  	from 		XDDDepositor D
  	where 		D.VendCust = @VendCust
  			and D.PNStatus LIKE @PNStatus
  			and D.FormatID = @FormatID		-- only want depositors w/ this format
			and exists(Select * from XDDTxnTypeDep TD (nolock) left outer join XDDTxnType T (nolock)
					ON TD.eStatus = T.eStatus 
					where 	TD.VendCust = D.VendCust
						and TD.Vendid = D.Vendid
						and TD.Selected = 1
						and T.TxnPreNote = 1
						and (  (@FormatID_Bat = 'US-ACH'  and T.TxnNACHA = 1)
						    or (@FormatID_Bat <> 'US-ACH' and T.TxnNACHA = 0)
						    )
				  )
  	ORDER by 	D.EntryClass, D.VendID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_TxnTypeDep_PN] TO [MSDSL]
    AS [dbo];

