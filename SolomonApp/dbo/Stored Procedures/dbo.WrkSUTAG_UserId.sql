 Create Proc  WrkSUTAG_UserId @parm1 varchar ( 47) as
       Select * From WrkSUTAG
           where UserId  =  @parm1
           order by UserId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkSUTAG_UserId] TO [MSDSL]
    AS [dbo];

