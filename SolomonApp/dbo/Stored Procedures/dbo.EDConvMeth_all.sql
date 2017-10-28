 CREATE PROCEDURE EDConvMeth_all
 @parm1 varchar( 3 ),
 @parm2 varchar( 3 ),
 @parm3 varchar( 1 )
AS
 SELECT *
 FROM EDConvMeth
 WHERE Trans LIKE @parm1
    AND ConvCode LIKE @parm2
    AND Direction LIKE @parm3
 ORDER BY Trans,
    ConvCode,
    Direction


