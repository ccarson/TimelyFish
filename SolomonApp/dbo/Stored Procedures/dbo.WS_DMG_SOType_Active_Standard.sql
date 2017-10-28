
CREATE proc WS_DMG_SOType_Active_Standard 
@FunctionID varchar (8)	
,@FunctionClass varchar (4)
,@CpnyID varchar (10)
,@SOTypeID varchar (4)
as  
	SELECT SOType.SOTypeID, SOType.Descr FROM SOType, SOStep where SOType.CpnyID = SOStep.CpnyID 
	AND SOType.SOTypeID = SOStep.SOTypeID AND SOStep.FunctionID = @FunctionID 
	AND SOStep.FunctionClass = @FunctionClass AND SOType.CpnyID LIKE @CpnyID 
	AND SOType.SOTypeID LIKE @SOTypeID AND SOType.Active = 1 
	AND SOType.SOTypeID IN ('BL','CM','DM','INVC','Q','RFC','SO') ORDER BY SOType.CpnyID, SOType.SOTypeID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_DMG_SOType_Active_Standard] TO [MSDSL]
    AS [dbo];

