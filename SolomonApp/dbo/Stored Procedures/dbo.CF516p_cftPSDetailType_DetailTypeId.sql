Create Procedure CF516p_cftPSDetailType_DetailTypeId @parm1 varchar (2) as 
    Select * from cftPSDetailType Where DetailTypeId Like @parm1
	Order by DetailTypeId
