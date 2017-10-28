 create proc DMG_CreditCheck_OrderBal
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@OrderBal	decimal(25,9) OUTPUT
as
	set @OrderBal = 0

	select		@OrderBal = h.UnshippedBalance
	from		SOHeader  h (NOLOCK)

	join		Terms	  t (NOLOCK)
	  on		t.TermsID = h.TermsID

	join		SOType    y (NOLOCK)
	  on		y.CpnyID = @CpnyID
	  and		y.SOTypeID = h.SOTypeID

	where		h.CpnyID = @CpnyID
	  and		h.OrdNbr = @OrdNbr
	  and		h.Status = 'O'
	  and		t.CreditChk = 1
	  and		y.Behavior in ('CM', 'CS', 'DM', 'INVC', 'RMSH', 'SO', 'WC')

	--select @OrderBal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditCheck_OrderBal] TO [MSDSL]
    AS [dbo];

