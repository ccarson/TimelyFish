Create Procedure CF392p_cftOrderType_OrdType @parm1 varchar (2) as 
    Select * from cftOrderType Where OrdType Like @parm1
	Order by OrdType
