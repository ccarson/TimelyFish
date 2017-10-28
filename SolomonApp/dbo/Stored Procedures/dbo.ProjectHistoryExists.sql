
CREATE PROCEDURE ProjectHistoryExists @parm1 varchar (16)  --project
AS

SELECT TOP(1) * 
   FROM PJPTDSUM 
  WHERE Project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectHistoryExists] TO [MSDSL]
    AS [dbo];

