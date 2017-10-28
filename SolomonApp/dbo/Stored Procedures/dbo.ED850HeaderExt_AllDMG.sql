 /****** Object:  Stored Procedure dbo.ED850HeaderExt_All    Script Date: 5/28/99 1:17:38 PM ******/
CREATE Proc ED850HeaderExt_AllDMG @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850HeaderExt Where CpnyId = @CpnyID And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850HeaderExt_AllDMG] TO [MSDSL]
    AS [dbo];

