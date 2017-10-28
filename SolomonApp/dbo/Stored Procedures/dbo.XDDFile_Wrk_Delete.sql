
CREATE PROCEDURE XDDFile_Wrk_Delete
   @FileType		varchar(1),
   @ComputerName	varchar(21)

AS
   DELETE
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and ComputerName = @ComputerName
