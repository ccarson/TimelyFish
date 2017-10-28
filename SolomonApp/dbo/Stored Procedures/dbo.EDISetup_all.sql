 CREATE PROCEDURE EDISetup_all
 @parm1 varchar( 2 )
AS
 SELECT *
 FROM EDISetup
 WHERE SetupID LIKE @parm1
 ORDER BY SetupID


