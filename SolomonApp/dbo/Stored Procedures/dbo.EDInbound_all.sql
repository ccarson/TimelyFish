 CREATE PROCEDURE EDInbound_all
 @parm1 varchar( 15 ),
 @parm2 varchar( 3 )
AS
 SELECT *
 FROM EDInbound
 WHERE CustId LIKE @parm1
    AND Trans LIKE @parm2
 ORDER BY CustId,
    Trans


