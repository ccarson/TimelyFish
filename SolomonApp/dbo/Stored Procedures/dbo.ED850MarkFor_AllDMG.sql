 /****** Object:  Stored Procedure dbo.ED850MarkFor_All    Script Date: 5/28/99 1:17:39 PM ******/
CREATE Proc ED850MarkFor_AllDMG @CpnyId varchar(10), @EDIPOID varchar(10)
As Select * From ED850MarkFor Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850MarkFor_AllDMG] TO [MSDSL]
    AS [dbo];

