 Create Proc ED850SDQ_SumQtyDiscTaken @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select Sum(Qty) From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
And DiscTaken = 1


