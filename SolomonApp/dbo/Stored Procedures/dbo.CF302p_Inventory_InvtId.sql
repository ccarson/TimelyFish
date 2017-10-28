Create Procedure CF302p_Inventory_InvtId @parm1 varchar (30) as 
    Select * from Inventory Where InvtId = @parm1 and TranStatusCode = 'AC'
