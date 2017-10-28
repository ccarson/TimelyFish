 Create Procedure EDContainer_UpdtTareId @CpnyId varchar(10), @ContainerId varchar(10), @TareId varchar(10) As
Update EDContainer Set TareId = @TareId Where CpnyId = @CpnyId And ContainerId = @ContainerId


