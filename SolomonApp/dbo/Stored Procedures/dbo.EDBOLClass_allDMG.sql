 /****** Object:  Stored Procedure dbo.EDBOLClass_all    Script Date: 5/28/99 1:17:39 PM ******/
CREATE PROCEDURE EDBOLClass_allDMG
 @parm1 varchar(20)
AS
 SELECT *
 FROM EDBOLClass
 WHERE BOLClass LIKE @parm1
 ORDER BY BOLClass


