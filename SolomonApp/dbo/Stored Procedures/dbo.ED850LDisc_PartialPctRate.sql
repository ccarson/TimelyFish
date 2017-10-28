 CREATE Proc ED850LDisc_PartialPctRate @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @LineQty float As
Select Pct, LDiscRate, Qty, AllChgQuantity, SpecChgCode From ED850LDisc Where CpnyId = @CpnyId
And EDIPOID = @EDIPOId And LineId = @LineId And TotAmt = 0 And (Qty Not In (0, @LineQty) Or
AllChgQuantity Not In (0, @LineQty))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LDisc_PartialPctRate] TO [MSDSL]
    AS [dbo];

