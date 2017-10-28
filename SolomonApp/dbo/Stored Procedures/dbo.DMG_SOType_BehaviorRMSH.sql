 CREATE PROCEDURE DMG_SOType_BehaviorRMSH
	@FunctionID	varchar(8),
	@FunctionClass	varchar(4),
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
AS
	select	SOType.*
	from	SOType, SOStep
	where	SOType.CpnyID = SOStep.CpnyID
	  and	SOType.SOTypeID = SOStep.SOTypeID
	  and	SOStep.FunctionID = @FunctionID
	  and	SOStep.FunctionClass = @FunctionClass
	  and	SOType.CpnyID LIKE @CpnyID
	  and	SOType.SOTypeID LIKE @SOTypeID
	  and	SOType.Active = 1
	  and	SOType.Behavior = 'RMSH'
	order by SOType.CpnyID,
	   	SOType.SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_BehaviorRMSH] TO [MSDSL]
    AS [dbo];

