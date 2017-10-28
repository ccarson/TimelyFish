
CREATE PROCEDURE XDDFile_Wrk_Last_Crtd_DateTime
   @ComputerName	varchar(21)
AS
 	SELECT TOP 1	FileType, EBFileNbr
 	FROM		XDDFile_Wrk (nolock)
 	WHERE		ComputerName = @ComputerName
 	ORDER BY	Crtd_DateTime DESC
