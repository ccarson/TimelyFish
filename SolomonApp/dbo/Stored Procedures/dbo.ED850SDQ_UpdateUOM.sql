 Create Proc ED850SDQ_UpdateUOM @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @UOM varchar(6) As
Update ED850SDQ Set UOM = @UOM Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


