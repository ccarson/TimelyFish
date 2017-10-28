 CREATE PROCEDURE DMG_SOType_BehaviorWO
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	SOType.*
	from	SOType
	where	SOType.CpnyID LIKE @CpnyID
	  and	SOType.SOTypeID LIKE @SOTypeID
	  and	SOType.Active = 1
	  and	SOType.Behavior = 'WO'
	order by SOType.CpnyID,
	   	SOType.SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_BehaviorWO] TO [MSDSL]
    AS [dbo];

