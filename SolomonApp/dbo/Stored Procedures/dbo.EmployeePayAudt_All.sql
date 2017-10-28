 Create Proc  EmployeePayAudt_All @parm1 varchar ( 4), @parm2 varchar( 4), @parm3beg datetime, @parm3end datetime as
       Select * from EmployeePayAudt
           where EmpId       =  @parm1
             and CalYr = @parm2
	     and Lupd_DateTime BETWEEN  @parm3beg and @parm3end
             
           order by EmpId, Lupd_DateTime

