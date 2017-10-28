
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
Create Procedure CF520p_GenPGList @parm1 varchar (16), @parm2 smalldatetime as 
    Select p.TaskId, Case When s.EstInvFlg = 1 Then p.EstInventory Else Coalesce((Select Sum(Qty) 
	from cfvPigGroupInv Where PigGroupId = p.PigGroupId and TranDate <= @parm2), 0) End 
	from cftPigGroup p Join cftPGStatus s on p.PgStatusId = s.PGStatusId 
	Where p.ProjectID = @parm1 and s.Status_Alloc = 'A'


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_GenPGList] TO [MSDSL]
    AS [dbo];

