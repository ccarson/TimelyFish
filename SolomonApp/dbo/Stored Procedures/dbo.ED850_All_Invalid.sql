 CREATE PROCEDURE ED850_All_Invalid
 @Parm1 varchar( 10 )
As
Select * from ED850Header Where UpdateStatus Not In ('OK','OC','H','IN','LM')
And CpnyId =  @Parm1 Order By EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850_All_Invalid] TO [MSDSL]
    AS [dbo];

