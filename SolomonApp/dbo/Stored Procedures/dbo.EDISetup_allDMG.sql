 /****** Object:  Stored Procedure dbo.EDISetup_all    Script Date: 5/28/99 1:17:42 PM ******/
CREATE PROCEDURE EDISetup_allDMG
 @parm1 varchar( 2 )
AS
 SELECT *
 FROM EDISetup
 WHERE SetupID LIKE @parm1
 ORDER BY SetupID


