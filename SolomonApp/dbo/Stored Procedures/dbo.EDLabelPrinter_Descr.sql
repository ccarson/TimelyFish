 Create Proc EDLabelPrinter_Descr @Name varchar(20) As
Select Descr From EDLabelPrinter Where Name = @Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabelPrinter_Descr] TO [MSDSL]
    AS [dbo];

