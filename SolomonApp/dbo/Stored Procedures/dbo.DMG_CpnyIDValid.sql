 create procedure DMG_CpnyIDValid
	@BaseCuryID	varchar(4),
	@DatabaseName	varchar(30),
	@CpnyID		varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	if (
	select	count(*)
	from	vs_Company (NOLOCK)
	where	BaseCuryID = @BaseCuryID
	and	DatabaseName = @DatabaseName
	and	CpnyID = @CpnyID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CpnyIDValid] TO [MSDSL]
    AS [dbo];

