 CREATE PROCEDURE WOPJCode_ALLM
   @Code_Value      varchar(30)

AS
   SELECT           *
   FROM             PJCODE
   WHERE            Code_Type = 'ALLM' and
                    Code_Value LIKE @Code_Value
   ORDER BY         Code_type, Code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJCode_ALLM] TO [MSDSL]
    AS [dbo];

