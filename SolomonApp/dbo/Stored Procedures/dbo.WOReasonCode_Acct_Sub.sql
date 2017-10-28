 create proc WOReasonCode_Acct_Sub
	@ReasonCd	varchar(6)
as
	select		DfltAcct, DfltSub
	from		ReasonCode
	where		ReasonCd = @ReasonCd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOReasonCode_Acct_Sub] TO [MSDSL]
    AS [dbo];

