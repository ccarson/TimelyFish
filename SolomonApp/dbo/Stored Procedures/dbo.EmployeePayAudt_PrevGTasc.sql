create Proc  [dbo].[EmployeePayAudt_PrevGTasc] @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25) as
       Select * from EmployeePayAudt
           where EmpId       =  @parm1
             and CalYr = @parm2 and AudtDateSort > @parm3
             
           order by EmpId, CalYr, audtdatesort asc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[EmployeePayAudt_PrevGTasc] TO [MSDSL]
    AS [dbo];

