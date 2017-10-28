Create Procedure CF343p_cfvMills_MillId @parm1 varchar (6) as 
    Select * from cfvMills Where MillId Like @parm1
	Order by MillId
