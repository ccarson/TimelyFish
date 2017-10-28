
CREATE PROCEDURE WSL_NoteRevisedDate
 @parm1  int
AS
  SET NOCOUNT ON
  SELECT dtRevisedDate
  FROM SNote
  WHERE nID = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_NoteRevisedDate] TO [MSDSL]
    AS [dbo];

