 Create Proc EDLabel_GetPrinter @Name varchar(30), @SiteId varchar(10) As
Select PrinterName From EDLabel Where Name = @Name And SiteId = @SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabel_GetPrinter] TO [MSDSL]
    AS [dbo];

