 Create Proc EDFOBPoint_GetId @Descr varchar(30) As
Select FOBID From FOBPoint Where Descr = @Descr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDFOBPoint_GetId] TO [MSDSL]
    AS [dbo];

