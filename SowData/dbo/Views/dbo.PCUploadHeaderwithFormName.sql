Create View dbo.PCUploadHeaderwithFormName
	AS
	Select fh.*, upall.FormName, upall.CountRows from PCUploadFormHeader fh LEFT join
		dbo.vDistinctPCUploadAll upall on fh.FarmID=upall.FarmID and fh.FormSerialID=upall.FormSerialID


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[PCUploadHeaderwithFormName] TO [se\analysts]
    AS [dbo];

