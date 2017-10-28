 CREATE Proc EDContainerDet_All @CpnyId varchar(10), @ContainerId varchar(10), @LineNbrMin smallint, @LineNbrMax smallint As
Select * From EDContainerDet Where CpnyId = @CpnyId And ContainerId = @ContainerId And LineNbr Between @LineNbrMin And @LineNbrMax



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_All] TO [MSDSL]
    AS [dbo];

