 CREATE Proc EDLabelPrinter_All @Name varchar(20) As
Select * From EDLabelPrinter Where Name Like @Name Order By Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabelPrinter_All] TO [MSDSL]
    AS [dbo];

