Create Procedure CF397p_cftFOImpTransl_FTI @parm1 varchar (1), @parm2 varchar (30) as 
    Select * from cftFOImpTransl Where FileType Like @parm1 and ItemId Like @parm2
	Order by FileType, ItemId
