 CREATE Proc EDContainer_TareCleanUp @CpnyId varchar(10), @ShipperId varchar(15) As
DELETE  From EDContainer  Where edcontainer.TareFlag <> 0  AND EDContainer.cpnyid = @cpnyid and edcontainer.Shipperid = @shipperid and  edcontainer.ContainerId Not In (Select B.TareId From EDContainer b
Where b.CpnyId = edcontainer.CpnyId And b.ShipperId = edcontainer.ShipperId And b.TareFlag =0)


