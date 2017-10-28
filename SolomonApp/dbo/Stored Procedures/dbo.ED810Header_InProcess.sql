 Create Proc ED810Header_InProcess @CpnyId varchar(10) As
Select EDIInvId From ED810Header Where CpnyId = @CpnyId And UpdateStatus = 'IN'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_InProcess] TO [MSDSL]
    AS [dbo];

