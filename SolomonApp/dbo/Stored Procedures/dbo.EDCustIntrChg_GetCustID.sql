 Create Proc EDCustIntrChg_GetCustID @Parm1 varchar(2), @Parm2 varchar(15), @Parm3 varchar(80),
@Parm4 varchar(80)
As
Declare @CustId varchar(15)
Select @CustId = CustId From EDCustIntrChg Where Qualifier = @Parm1 And Id = @Parm2 And EDIBillToRef = @Parm3
If IsNull(@CustId,'~') = '~'
  Begin
  Select @CustId = CustId From EDCustIntrChg Where Qualifier = @Parm1 And Id = @Parm2 And LTrim(EDIBillToRef) = ''
  If IsNull(@CustId,'~') = '~'
    Begin
    Select @CustId = CustId From EDCustIntrChg Where Qualifier = @Parm1 And Id = @Parm2 And EDIBillToRef = @Parm4
    End
  End
Select @CustId


