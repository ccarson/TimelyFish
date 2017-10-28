 CREATE Proc EDContainer_CountPickPack @BOLNbr varchar(20), @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*) From EDContainer A Where BOLNbr = @BOLNbr And PackMethod <> 'SC' And ContainerId
Not In (Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = ShipperId)


