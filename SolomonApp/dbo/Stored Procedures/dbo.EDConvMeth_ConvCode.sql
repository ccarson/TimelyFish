 CREATE PROCEDURE EDConvMeth_ConvCode
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDConvMeth
 WHERE ConvCode LIKE @parm1
 ORDER BY ConvCode


