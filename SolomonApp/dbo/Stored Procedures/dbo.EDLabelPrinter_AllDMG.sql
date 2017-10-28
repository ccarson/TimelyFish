 Create Proc EDLabelPrinter_AllDMG As
Select * From EDLabelPrinter Order By Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabelPrinter_AllDMG] TO [MSDSL]
    AS [dbo];

