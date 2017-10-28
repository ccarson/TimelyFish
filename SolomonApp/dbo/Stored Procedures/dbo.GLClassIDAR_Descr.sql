 Create Proc GLClassIDAR_Descr @parm1 varchar (4) as
    Select Descr from custglclass where GLClassID = @parm1 order by GLClassID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLClassIDAR_Descr] TO [MSDSL]
    AS [dbo];

