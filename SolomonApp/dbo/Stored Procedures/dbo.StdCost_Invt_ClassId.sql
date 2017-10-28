 Create Proc StdCost_Invt_ClassId
    @parm1 varchar ( 6)
as
Select * from Inventory
    Where ClassId Like @parm1
    And Valmthd = 'T'
Order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Invt_ClassId] TO [MSDSL]
    AS [dbo];

