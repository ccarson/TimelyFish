 Create Proc EDFOBPoint_Descr @FOBId varchar(15) As
Select Descr From FOBPoint Where FOBID = @FOBID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDFOBPoint_Descr] TO [MSDSL]
    AS [dbo];

