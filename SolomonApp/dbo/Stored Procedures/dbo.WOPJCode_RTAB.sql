 CREATE PROCEDURE WOPJCode_RTAB
   @Code_Value      varchar(30)

AS
   SELECT           *
   FROM             PJCODE
   WHERE            Code_Type = 'RTAB' and
                    Code_Value LIKE @Code_Value
   ORDER BY         Code_type, Code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJCode_RTAB] TO [MSDSL]
    AS [dbo];

