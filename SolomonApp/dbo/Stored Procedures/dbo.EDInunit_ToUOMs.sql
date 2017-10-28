 -- only used by a PV
Create Proc EDInunit_ToUOMs @UOM varchar(6)As
Select Distinct ToUnit From InUnit Where ToUnit Like @UOM Order By ToUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInunit_ToUOMs] TO [MSDSL]
    AS [dbo];

