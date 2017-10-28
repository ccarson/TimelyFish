Create Procedure CF518p_cftPSDetailType_DetailTypeId @parm1 varchar (2) as 
    Select * from cftPSDetailType Where DetailTypeId = @parm1
