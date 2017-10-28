Create Procedure CF391p_cftOrderStatus_Status @parm1 varchar (10) as 
    Select * from cftOrderStatus Where Status Like @parm1
	Order by Status
