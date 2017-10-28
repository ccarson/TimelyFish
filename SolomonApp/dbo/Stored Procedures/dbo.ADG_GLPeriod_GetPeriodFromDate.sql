 create procedure ADG_GLPeriod_GetPeriodFromDate
	@Date			smalldatetime,
	@UseCurrentOMPeriod	smallint
as
	declare @Period	varchar(6)

	execute ADG_GLPeriod_GetPerFromDateOut @Date, @UseCurrentOMPeriod, @Period output

	select @Period Period


