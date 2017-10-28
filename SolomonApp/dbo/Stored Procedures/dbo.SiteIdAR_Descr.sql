 Create Proc SiteIdAR_Descr @parm1 varchar ( 10) as
    Select name from Site where SiteID = @parm1 order by SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SiteIdAR_Descr] TO [MSDSL]
    AS [dbo];

