 CREATE Proc EDContainer_CountWeightVolume @CpnyId varchar(10), @ShipperId varchar(10) As
Select Sum(Weight), Min(WeightUOM), Max(WeightUOM), Sum(Volume), Min(VolumeUOM), Max(VolumeUOM),
Min(PackMethod), Max(PackMethod), Count(*), Sum(ShpWeight) From EDContainer Where
CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0


