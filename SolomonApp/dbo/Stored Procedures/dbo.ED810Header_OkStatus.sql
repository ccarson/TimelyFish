 CREATE Proc ED810Header_OkStatus @CpnyId varchar(10) As
Select * From ED810Header Where CpnyId = @CpnyId And UpdateStatus = 'OK'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_OkStatus] TO [MSDSL]
    AS [dbo];

