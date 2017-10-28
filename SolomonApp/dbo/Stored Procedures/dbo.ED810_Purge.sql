 Create Proc ED810_Purge @CpnyId varchar(10), @VendId varchar(15), @PODateFrom smalldatetime, @PODateTo smalldatetime As
Select EDIInvId Into #EDIPurge From ED810Header Where CpnyId = @CpnyId And VendId Like @VendId And
PODate >= @PODateFrom And PODate <= @PODateTo And UpdateStatus = 'RC'

Delete From ED810Header Where CpnyId = @CpnyId And EDIInvId In (Select EDIInvId From #EDIPurge)
Delete From ED810LineItem Where CpnyId = @CpnyId And EDIInvId In (Select EDIInvId From #EDIPurge)
Delete From ED810Split Where CpnyId = @CpnyId And EDIInvId In (Select EDIInvId From #EDIPurge)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810_Purge] TO [MSDSL]
    AS [dbo];

