 Create	Procedure SCM_10223_Fetch_PODate
	@RcptNbr	VarChar(15)
As
	select PODate from PurchOrd
	join (select distinct t.ponbr from poreceipt r
	inner join potran t on t.rcptnbr = r.rcptnbr where r.RcptNbr = @RcptNbr) v on v.ponbr = PurchOrd.ponbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10223_Fetch_PODate] TO [MSDSL]
    AS [dbo];

