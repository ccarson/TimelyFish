 CREATE PROCEDURE EDMiscChargeSS_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 )
AS
 SELECT *
 FROM EDMiscChargeSS
 WHERE MiscChrgId LIKE @parm1
    AND Code LIKE @parm2
 ORDER BY MiscChrgId,
    Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDMiscChargeSS_all] TO [MSDSL]
    AS [dbo];

