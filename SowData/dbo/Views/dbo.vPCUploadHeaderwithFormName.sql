Create View dbo.vPCUploadHeaderwithFormName
	AS
	Select fh.*, upall.FormName, upall.CountRows from PCUploadFormHeader fh LEFT join
		dbo.vDistinctPCUploadAll upall on fh.FarmID=upall.FarmID and fh.FormSerialID=upall.FormSerialID
	where fh.TransferStatus<>-1


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPCUploadHeaderwithFormName] TO [se\analysts]
    AS [dbo];

