 CREATE PROCEDURE ED850Get_PODate
@parm1 varchar( 10 ),
@parm2 varchar( 10 )
as
select * from ED850HeaderExt where EDIPoId = @parm1 and CpnyId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Get_PODate] TO [MSDSL]
    AS [dbo];

