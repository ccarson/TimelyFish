 Create Proc Comp_CmpId_Site_Status @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1) as
            Select * from Component where CmpnentId = @parm1 And siteid = @parm2 and
                status = @parm3
                order by CmpnentId, siteid, status

--UGK  086992



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_CmpId_Site_Status] TO [MSDSL]
    AS [dbo];

