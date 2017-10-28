 CREATE Proc ED850LDisc_LineItem @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And Lineid = @LineId
Order By CpnyId, EDIPOID, LineId,LineNbr


