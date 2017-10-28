 Create Proc EDMiscCharge_EDICode @MiscChrgId varchar(10) As
Select S4Future11 From MiscCharge Where MiscChrgId = @MiscChrgId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDMiscCharge_EDICode] TO [MSDSL]
    AS [dbo];

