 create proc EDContainerDet_CountInvtid
@ContainerID varchar(10)
as
select count(distinct invtid) from edcontainerdet where containerid = @ContainerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_CountInvtid] TO [MSDSL]
    AS [dbo];

