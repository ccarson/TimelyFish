 Create Proc WrkDefExpt_DEL_All @parm1 smallint as
Delete from WrkDefExpt
where RI_ID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkDefExpt_DEL_All] TO [MSDSL]
    AS [dbo];

