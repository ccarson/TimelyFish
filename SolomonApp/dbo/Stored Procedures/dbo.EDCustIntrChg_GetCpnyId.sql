 Create Proc EDCustIntrChg_GetCpnyId @Id varchar(15), @Qualifier varchar(2), @EDIBillToRef varchar(80) As
Declare @CpnyId varchar(10)
Select @CpnyId = CpnyId From EDCustIntrChg Where Id = @Id And Qualifier = @Qualifier And EDIBillToRef = @EDIBillToRef
If IsNull(@CpnyId,'~') = '~'
  Select @CpnyId = CpnyId From EDCustIntrChg Where Id = @Id And Qualifier = @Qualifier And LTrim(EDIBillToRef) = ''
Select @CpnyId


