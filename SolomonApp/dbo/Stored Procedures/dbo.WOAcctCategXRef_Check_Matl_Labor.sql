 CREATE PROCEDURE WOAcctCategXRef_Check_Matl_Labor
AS
	Set NoCount On

	Declare	@MatlAcct	varchar( 16 )
	Declare @LaborAcct	varchar( 16 )

	Select 	@MatlAcct = Material_Acct
	FROM	WOSetup (nolock)

	Select 	@LaborAcct = Labor_Acct
	FROM	WOSetup (nolock)

	-- We should at least have two records in WOAcctCategXRef
	-- matching the WOSetup table's Matl/Labor acct
	select	case when count(*) >= 2
		then 1
		else 0
		end
	from	WOAcctCategXRef (nolock)
	where	Acct = @MatlAcct
		or Acct = @LaborAcct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOAcctCategXRef_Check_Matl_Labor] TO [MSDSL]
    AS [dbo];

