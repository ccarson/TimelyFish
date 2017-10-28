 create procedure DMG_OU_AutoGeneratePO
	@CpnyID as varchar(10),
	@SOTypeID as varchar(4),
	@GeneratesPOs as smallint OUTPUT
as
	if exists
		(select CpnyID
		from SOStep (NOLOCK)
		where CpnyID = @CpnyID
			and SOTypeID = @SOTypeID
			and FunctionID = '6040000')

		set @GeneratesPOs = 1
	else
		set @GeneratesPOs = 0

	return 1 --Success


