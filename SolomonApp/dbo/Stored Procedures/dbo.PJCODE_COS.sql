 CREATE PROCEDURE PJCODE_COS
	@project varchar(16),
	@code_type varchar(8)
	
AS

	declare @code_value as varchar(8)
	 
	 select @code_value = bill_type_cd from pjbill where project_billwith = @project
	
	select	*
	from	PJCODE
	where	code_type = @code_type
	and	code_value = @code_value




GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_COS] TO [MSDSL]
    AS [dbo];

