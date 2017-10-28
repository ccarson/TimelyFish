 Create Proc  PRSetup_Update1 @parm1 varchar ( 6) as
       Update PRSetup
           Set EmpRGP = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRSetup_Update1] TO [MSDSL]
    AS [dbo];

