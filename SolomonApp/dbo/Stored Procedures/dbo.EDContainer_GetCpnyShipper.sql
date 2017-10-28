 CREATE Proc EDContainer_GetCpnyShipper @ContainerId varchar(10) As
Select CpnyId, ShipperId From EDContainer Where ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetCpnyShipper] TO [MSDSL]
    AS [dbo];

