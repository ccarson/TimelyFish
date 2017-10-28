
--*************************************************************
--	Purpose: Check for open batchs before closing the group
--	Author: Sue Matter
--	Date: 4/25/2006
--	Usage: Pig Group Maintenance 
--	Parms: @parm1 (TaskId)
--*************************************************************

CREATE Procedure pCF511p_PJChargH_OpenPG @parm1 varchar (32) 
as 
    	Select * 
	from PJChargH Where Batch_Status <> 'P' 
	and Exists (Select * from PJChargD 
	Where Batch_Id = PJChargH.Batch_Id and pjt_entity = @parm1)

