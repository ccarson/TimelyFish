 Create Proc  WrkSUTAD_UserId @parm1 varchar ( 47) as
       Select * From WrkSUTAD
           where UserId  =  @parm1
           order by UserId,
                    EmployeeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkSUTAD_UserId] TO [MSDSL]
    AS [dbo];

