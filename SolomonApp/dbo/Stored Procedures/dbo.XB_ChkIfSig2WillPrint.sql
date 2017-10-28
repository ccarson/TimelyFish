Create Procedure XB_ChkIfSig2WillPrint @BatNbr varchar(10), @Moudle varchar(2), @Limit float, @BankLimit float as
if @Moudle='AP'
	select 1 from APCheck where CheckAmt<>0 and CheckAmt>@BankLimit and CheckAmt<=@Limit and BatNbr=@BatNbr
else
	select 1 from Employee where CurrNet<>0 and CurrNet>@BankLimit and CurrNet<=@Limit and CurrBatNbr=@BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XB_ChkIfSig2WillPrint] TO [MSDSL]
    AS [dbo];

