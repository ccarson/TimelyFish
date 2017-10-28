 create procedure ADG_GLPeriod_GetEndDateFromPer
	@Period			varchar (6)
as
	declare @PerEnd		varchar (4)

	execute ADG_GLPeriod_EndDateFromPerOut @Period, @PerEnd output

	select @PerEnd PerEnd


