 Create Proc EDContainerDet_MaxLineNbr @ContainerId varchar(10) As
Select Max(LineNbr) From EDContainerDet Where ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_MaxLineNbr] TO [MSDSL]
    AS [dbo];

