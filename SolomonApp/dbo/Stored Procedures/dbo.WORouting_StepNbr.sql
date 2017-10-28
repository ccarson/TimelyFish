 create proc WORouting_StepNbr
	@WONbr			varchar( 16 ),
	@Task			varchar( 32 ),
	@StepNbr		smallint
AS
		SELECT 			*
	FROM 			WORouting (NoLock)
	WHERE 			WONbr = @WONbr
				and Task = @Task
				and StepNbr LIKE @StepNbr
	ORDER BY 		WONbr, Task, StepNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORouting_StepNbr] TO [MSDSL]
    AS [dbo];

