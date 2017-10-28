 Create Proc  PRSetup_All as
       Select * from PRSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRSetup_All] TO [MSDSL]
    AS [dbo];

