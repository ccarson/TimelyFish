 CREATE PROCEDURE EDCustIntrchg_all
 @parm1 varchar( 15 ),
 @parm2 varchar( 2 ),
 @parm3 varchar( 15 ),
 @parm4 varchar( 80 ),
 @parm5 varchar( 10 )
AS
 SELECT *
 FROM EDCustIntrchg
 WHERE CustId LIKE @parm1
    AND Qualifier LIKE @parm2
    AND Id LIKE @parm3
    AND EDIBillToRef LIKE @parm4
    AND CpnyId LIKE @parm5
 ORDER BY CustId,
    Qualifier,
    Id,
    EDIBillToRef,
    CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCustIntrchg_all] TO [MSDSL]
    AS [dbo];

