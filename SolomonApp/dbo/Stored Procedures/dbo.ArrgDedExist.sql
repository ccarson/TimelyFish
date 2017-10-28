 Create Proc ArrgDedExist @parm1 varchar (4) as
       Select max(ArrgDedAllow) from Deduction
            where CalYr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ArrgDedExist] TO [MSDSL]
    AS [dbo];

