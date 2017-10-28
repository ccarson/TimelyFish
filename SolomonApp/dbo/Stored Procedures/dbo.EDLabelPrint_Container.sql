 Create Proc EDLabelPrint_Container @ContainerId varchar(10) As
Update EDContainer Set LabelLastPrinted = GetDate() Where ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabelPrint_Container] TO [MSDSL]
    AS [dbo];

