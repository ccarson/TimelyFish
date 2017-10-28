 CREATE PROCEDURE WOPJContrl_Control_Data_Get
	@Control_Type	varchar( 2 ),
	@Control_Code	varchar( 30 )
AS
	SELECT 		Control_Data
	FROM 		PJContrl (NoLock)
	WHERE 		Control_Type LIKE @Control_Type
	   		and Control_Code LIKE @Control_Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJContrl_Control_Data_Get] TO [MSDSL]
    AS [dbo];

