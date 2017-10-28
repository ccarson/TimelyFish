
/****** Object:  Stored Procedure dbo.CF522p_PJChargH_OpenPG    Script Date: 4/26/2005 9:35:21 AM ******/
CREATE  Procedure CF522p_PJChargH_OpenPG @parm1 varchar (32) as 
    Select * from PJChargH Where Batch_Status <> 'P' and Exists (Select * from PJChargD 
	Where Batch_Id = PJChargH.Batch_Id and pjt_entity = @parm1)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_PJChargH_OpenPG] TO [MSDSL]
    AS [dbo];

