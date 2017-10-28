 /****** Object:  Stored Procedure dbo.EDVendor_All    Script Date: 5/28/99 1:17:46 PM ******/
CREATE PROCEDURE EDVendor_AllDMG
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDVendor
 WHERE VendId LIKE @parm1
 ORDER BY VendId


