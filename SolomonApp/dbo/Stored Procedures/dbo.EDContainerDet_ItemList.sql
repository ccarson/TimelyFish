 CREATE PROCEDURE EDContainerDet_ItemList @CpnyId varchar(10), @ShipperId varchar(15) As
Select *
From EDContainer
	left outer join EDContainerDet
		on EDContainer.ContainerId = EDContainerDet.ContainerId
Where EDContainer.CpnyId = @CpnyId And
	EDContainer.ShipperId = @ShipperId And
	EDContainer.TareFlag = 0
Order By EDContainerDet.InvtId,EDContainer.TareId,EDContainerDet.ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ItemList] TO [MSDSL]
    AS [dbo];

