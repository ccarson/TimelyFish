
Create Proc INVENTORY_INVTIDDescr @parm1 varchar ( 30) as
        Select Descr from Inventory where InvtId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INVENTORY_INVTIDDescr] TO [MSDSL]
    AS [dbo];

