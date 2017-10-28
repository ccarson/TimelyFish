 Create Proc Comp_CmpId_Site_Stat_KStat @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4 varchar ( 1) as
            Select * from Component where CmpnentId = @parm1 And siteid = @parm2 and
                status = @parm3 and Kitstatus = @parm4
                order by CmpnentId, siteid, status, kitstatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_CmpId_Site_Stat_KStat] TO [MSDSL]
    AS [dbo];

