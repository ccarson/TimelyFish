
CREATE PROCEDURE WS_LAST_PJNOTE @parm1 VARCHAR (4),
								@parm2 VARCHAR (64)
AS
    SELECT TOP 1 notes1
    FROM   PJNOTES
    WHERE  note_type_cd = @parm1
           AND key_value = @parm2
    ORDER  BY key_index DESC 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_LAST_PJNOTE] TO [MSDSL]
    AS [dbo];

