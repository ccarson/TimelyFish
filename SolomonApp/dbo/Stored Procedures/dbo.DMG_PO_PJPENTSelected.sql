 create procedure DMG_PO_PJPENTSelected
	@project	varchar(16),
	@pjt_entity	varchar(32),
	@pe_id01	varchar(30) OUTPUT
as
	select	@pe_id01 = ltrim(rtrim(pe_id01))
	from	PJPENT (NOLOCK)
	where	status_pa = 'A'
	and	status_po = 'A'
	and	project = @project
	and	pjt_entity = @pjt_entity

	if @@ROWCOUNT = 0 begin
		set @pjt_entity = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_PJPENTSelected] TO [MSDSL]
    AS [dbo];

