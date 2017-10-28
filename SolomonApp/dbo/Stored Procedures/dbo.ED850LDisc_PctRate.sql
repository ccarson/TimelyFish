 CREATE Proc ED850LDisc_PctRate @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @LineQty float As
Select Pct, LDiscRate, SpecChgCode From ED850LDisc A Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And
LineId = @LineId And (LDiscRate > 0 Or Pct > 0) And Indicator = 'A'  And Qty In (0, @LineQty) And
AllChgQuantity In (0, @LineQty)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LDisc_PctRate] TO [MSDSL]
    AS [dbo];

