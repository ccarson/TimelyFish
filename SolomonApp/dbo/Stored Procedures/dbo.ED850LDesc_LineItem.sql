 CREATE Proc ED850LDesc_LineItem @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LDesc Where CpnyId = @CpnyId And EDIPOID= @EDIPOID And Lineid = @LineId
Order By CpnyId, EDIPOID, LineId, LineNbr


