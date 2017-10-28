 Create Proc EDInSetup_DecPl As
Select DecPlPrcCst, DecPlQty From Insetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInSetup_DecPl] TO [MSDSL]
    AS [dbo];

