Create Procedure XB_ChkIfSig1WillPrint @BatNbr varchar(10), @Module varchar(2), @Limit float as
if (@Module='AP')
	select 1 from APCheck where CheckAmt<=@Limit and BatNbr=@BatNbr
else
	select 1 from Employee where CurrNet<=@Limit and CurrNet<>0 and CurrBatNbr=@BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XB_ChkIfSig1WillPrint] TO [MSDSL]
    AS [dbo];

