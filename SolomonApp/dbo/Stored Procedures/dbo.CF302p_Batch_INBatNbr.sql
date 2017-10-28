Create Procedure CF302p_Batch_INBatNbr @parm1 varchar (10) as 
    Select * from Batch Where Module = 'IN' and BatNbr = @parm1
