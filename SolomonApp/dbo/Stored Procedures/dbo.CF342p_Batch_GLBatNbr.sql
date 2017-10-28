Create Procedure CF342p_Batch_GLBatNbr @parm1 varchar (10) as 
    Select * from Batch Where BatNbr = @parm1 and Module = 'GL'
