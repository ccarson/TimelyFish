Create Procedure CF302p_cftMillSite_CpnyId @parm1 varchar (10) as 
    Select * from cftMillSite Where CpnyId = @parm1
