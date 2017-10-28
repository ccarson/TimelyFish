 create proc Get_ConfirmShipStep
	@SOTypeID	varchar(4),
	@CpnyID		varchar(10)
as
    SELECT FunctionClass, FunctionID
      FROM SOStep 
     WHERE SOTypeID = @SOTypeID and CpnyID = @CpnyID AND EventType = 'CSHP'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_ConfirmShipStep] TO [MSDSL]
    AS [dbo];

