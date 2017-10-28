 Create Proc  EarndedAudt_All @parm1 varchar ( 10), @parm2 varchar( 4), @parm3beg datetime, @parm3end datetime as
       Select * from EarndedAudt
           where EmpId       =  @parm1
             and CalYr = @parm2
	     and Lupd_DateTime BETWEEN  @parm3beg and @parm3end
             
           order by EmpId, Lupd_DateTime, EarnDedId

