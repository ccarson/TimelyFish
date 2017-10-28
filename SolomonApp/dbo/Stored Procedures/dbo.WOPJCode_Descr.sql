 CREATE PROCEDURE WOPJCode_Descr
	@Code_Type	varchar( 4 ),
   	@Code_Value	varchar( 30 )

AS

	SELECT 		code_value_desc
 	FROM 		PJCode
 	WHERE 		Code_Type = @Code_Type
   			and Code_Value = @Code_Value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJCode_Descr] TO [MSDSL]
    AS [dbo];

