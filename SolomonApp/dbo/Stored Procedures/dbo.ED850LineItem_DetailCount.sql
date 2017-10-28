 CREATE Proc ED850LineItem_DetailCount @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Declare @DescrCount int
Declare @SDQCount int
Declare @DiscCount int
Declare @ServicesCount int
Declare @SchedCount int
Declare @SubLineItemCount int
Select @DescrCount = Count(*) From ED850LDesc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @SDQCount = Count(*) From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @DiscCount = Count(*) From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @ServicesCount = Count(*) From ED850LSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @SchedCount = Count(*) From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @SubLineItemCount = Count(*) From ED850SubLineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Select @DescrCount, @SDQCount, @DiscCount, @ServicesCount, @SchedCount, @SubLineItemCount


