 Create Proc  PRAutoBatchNbr as
       Select LastBatNbr from PRSetup order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRAutoBatchNbr] TO [MSDSL]
    AS [dbo];

