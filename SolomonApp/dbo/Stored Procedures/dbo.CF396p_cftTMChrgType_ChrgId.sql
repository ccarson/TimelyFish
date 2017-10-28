Create Procedure CF396p_cftTMChrgType_ChrgId @parm1 varchar (5) as 
    Select * from cftTMChrgType Where ChrgId Like @parm1
	Order by ChrgId
