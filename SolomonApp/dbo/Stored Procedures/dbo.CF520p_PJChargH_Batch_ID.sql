Create Procedure CF520p_PJChargH_Batch_ID @parm1 varchar (10) as 
    Select * from PJChargH Where Batch_Id = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_PJChargH_Batch_ID] TO [MSDSL]
    AS [dbo];

