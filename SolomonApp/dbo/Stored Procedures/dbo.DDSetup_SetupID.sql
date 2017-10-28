 Create Proc DDSetup_SetupID @parm1 varchar ( 2) as
    Select * from DDSetup where SetupID LIKE @parm1 ORDER by SetupId


