 CREATE PROCEDURE ED850Lineitem_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 ),
 @parm3min smallint, @parm3max smallint
AS
 SELECT *
 FROM ED850Lineitem
 WHERE Cpnyid LIKE @parm1
    AND EDIPoId LIKE @parm2
    AND LineNbr BETWEEN @parm3min AND @parm3max
 ORDER BY Cpnyid,
    EDIPoId,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lineitem_all] TO [MSDSL]
    AS [dbo];

