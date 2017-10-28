 Create Proc  EarndedAudt_EmpID_CalYr2 @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25), @parm4 varchar(10) as
       Select * from EarndedAudt
           where EmpId       =  @parm1
             and CalYr = @parm2 and AudtDateSort = @parm3 and earndedid = @parm4
	    
             
           order by EmpId, CalYr, audtdatesort, earndedid

