Create Procedure CF302p_cftFOImpTransl_FI @parm1 varchar (1), @parm2 varchar (30) as 
    Select * from cftFOImpTransl Where FileType = @parm1 and ItemId = @parm2
