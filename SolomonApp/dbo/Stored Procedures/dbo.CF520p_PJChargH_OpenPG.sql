Create Procedure CF520p_PJChargH_OpenPG @parm1 varchar (2) as 
    Select * from PJChargH Where Batch_Status <> 'P' and Exists (Select * from PJChargD 
	Where Batch_Id = PJChargH.Batch_Id and Left(Project, 2) = @parm1)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_PJChargH_OpenPG] TO [MSDSL]
    AS [dbo];

