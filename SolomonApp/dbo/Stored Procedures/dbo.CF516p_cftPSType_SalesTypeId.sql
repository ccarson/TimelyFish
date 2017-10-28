Create Procedure CF516p_cftPSType_SalesTypeId @parm1 varchar (2) as 
    Select * from cftPSType Where SalesTypeId Like @parm1
	Order by SalesTypeId
