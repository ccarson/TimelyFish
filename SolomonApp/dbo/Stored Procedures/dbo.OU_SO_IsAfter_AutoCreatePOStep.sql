 create proc OU_SO_IsAfter_AutoCreatePOStep
	@CpnyID			varchar (10),
	@OrdNbr			varchar (15)
as
	declare	@SOTypeID	varchar (4)
	declare	@CurrSeq	varchar (4)

	-- Get the Order Step for the SO's Next Step
	select	@SOTypeID = SOStep.SOTypeID,
		@CurrSeq = SOStep.Seq
	from	SOStep
	join	SOHeader
	on	SOStep.SOTypeID = SOHeader.SOTypeID
	and	SOStep.CpnyID = SOHeader.CpnyID
	and	SOStep.FunctionID = SOHeader.NextFunctionID
	and	SOStep.FunctionClass = SOHeader.NextFunctionClass
	where	SOHeader.OrdNbr = @OrdNbr

	-- See if the Auto Create PO Step is before the current step
	select	count(*)
	from	SOStep
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID
	and	Status <> 'D'
	and	Seq < @CurrSeq
	and	FunctionID = '6040000'
	and	AutoPgmID not like 'x%'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_SO_IsAfter_AutoCreatePOStep] TO [MSDSL]
    AS [dbo];

