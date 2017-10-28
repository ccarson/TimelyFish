 /****** Object:  Stored Procedure dbo.EDITranSet_all    Script Date: 5/28/99 1:17:43 PM ******/
CREATE PROCEDURE EDITranSet_allDMG
 @parm1 varchar( 6 )
AS
 SELECT *
 FROM EDITranSet
 WHERE TranSetID LIKE @parm1
 ORDER BY TranSetID


