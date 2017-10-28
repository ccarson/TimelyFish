Create Procedure CF302p_cftMillSite_MillId @parm1 varchar (10) as 
    Select * from cftMillSite Where MillId = @parm1
