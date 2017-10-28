 Create Proc ED850SDQ_MoveDiscTaken @CpnyId varchar(10), @EDIPOID varchar(10), @OldLineId int, @NewLineId int As
Update ED850SDQ Set LineId = @NewLineId Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId =
@OldLineId And DiscTaken = 1


