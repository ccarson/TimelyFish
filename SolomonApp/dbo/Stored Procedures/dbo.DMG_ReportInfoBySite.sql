 create proc DMG_ReportInfoBySite
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@FunctionID	varchar(8),
	@FunctionClass	varchar(4),
	@SiteID		varchar(10),
	@DeviceName	varchar(40) OUTPUT,
	@ReportFormat	varchar(30) OUTPUT,
	@ReportName	varchar(30) OUTPUT,
	@NotesOn	smallint OUTPUT
as
	declare @CurrSeq	varchar(4)
	declare @SiteKey	varchar(10)

	-- Initialize the output parameters
	set @DeviceName = ''
	set @ReportFormat = ''
	set @ReportName = ''
	set @NotesOn = 0

	-- Determine the Seq for the current function and class.
	select	@CurrSeq = ltrim(rtrim(seq))
	from 	SOStep (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeId
	and	FunctionID = @FunctionID
	and	FunctionClass = @FunctionClass

	-- Set the default value for @sitekey to 'DEFAULT'.  If the next select fails
	-- to find any records, @SiteKey will retain this value.
	select	@SiteKey = 'DEFAULT'

	-- Try to find a record in SOPrintControl for the specified site.
	select 	@SiteKey = ltrim(rtrim(SiteID))
	from	SOPrintControl (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID
	and	seq = @CurrSeq
	and	SiteID = @SiteID

	-- Now that we know the correct site ID, select the correct SOPrintControl record.
	select	@DeviceName = case when c.DeviceName is null then '' else ltrim(rtrim(c.DeviceName)) end,
		@ReportFormat = case when c.ReportFormat is null then '' else ltrim(rtrim(c.ReportFormat)) end,
		@ReportName = case when c.ReportName is null then '' else ltrim(rtrim(c.ReportName)) end,
		@NotesOn = s.Noteson
	from	SOStep s (NOLOCK)
	left join SOPrintControl c (NOLOCK) on s.CpnyID = c.CpnyID and s.SOTypeID = c.SOTypeID and s.seq = c.seq
	where	s.CpnyID = @CpnyID
	and	s.SOTypeID = @SOTypeID
	and	s.seq = @CurrSeq
	and	(c.SiteID = @SiteKey or c.SiteID is null)

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		--select @DeviceName,@ReportFormat,@ReportName,@NotesOn
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ReportInfoBySite] TO [MSDSL]
    AS [dbo];

