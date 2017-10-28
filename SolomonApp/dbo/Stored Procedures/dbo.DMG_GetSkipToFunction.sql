 create proc DMG_GetSkipToFunction
	@cpnyid		varchar(10),
	@sotypeid	varchar(4),
	@skipto		varchar(4),
	@FunctionID	varchar(8) OUTPUT,
	@FunctionClass	varchar(4) OUTPUT
as
	select	top 1
		@FunctionID = ltrim(rtrim(functionid)),
		@FunctionClass = ltrim(rtrim(functionclass))
	from	sostep (NOLOCK)
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	seq >= @skipto
	  and	status <> 'D'

	if @@ROWCOUNT = 0 begin
		set @FunctionID = ''
		set @FunctionClass = ''
		return 0	--Failure
	end
	else
		--select @FunctionID, @FunctionClass
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetSkipToFunction] TO [MSDSL]
    AS [dbo];

