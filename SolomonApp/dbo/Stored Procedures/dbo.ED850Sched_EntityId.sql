 CREATE PROCEDURE ED850Sched_EntityId
 @parm1 varchar( 80 )
AS
 SELECT *
 FROM ED850Sched
 WHERE EntityId LIKE @parm1
 ORDER BY EntityId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_EntityId] TO [MSDSL]
    AS [dbo];

