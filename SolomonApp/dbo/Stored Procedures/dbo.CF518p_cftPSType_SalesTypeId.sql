Create Procedure CF518p_cftPSType_SalesTypeId @parm1 varchar (2) as 
    Select * from cftPSType Where SalesTypeId = @parm1
