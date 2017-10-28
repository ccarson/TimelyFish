 Create Proc EDDataElement_GetDescr @Segment varchar(5), @Position varchar(2), @Code varchar(15) As
Select Description From EDDataElement Where Segment = @Segment And Position = @Position And Code = @Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_GetDescr] TO [MSDSL]
    AS [dbo];

