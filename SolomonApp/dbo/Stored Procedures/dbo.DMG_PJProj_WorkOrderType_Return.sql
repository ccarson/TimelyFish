 create proc DMG_PJProj_WorkOrderType_Return
	@Project	varchar(16),
	@Status_20	varchar(1) OUTPUT
as
	select	@Status_20 = ltrim(rtrim(Status_20))
	from	PJProj (NOLOCK)
	where	Project = @Project

	if @@ROWCOUNT = 0 begin
		set @Status_20 = ''
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


