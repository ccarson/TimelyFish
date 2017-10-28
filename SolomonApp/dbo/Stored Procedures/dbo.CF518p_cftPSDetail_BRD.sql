Create Procedure CF518p_cftPSDetail_BRD (@parm1 varchar (10), @parm2 varchar (10), @parm3 smallint, @parm4 smallint) as 
    Select * from cftPSDetail Where BatNbr = @parm1 and RefNbr = @parm2 and LineNbr between @parm3 and @parm4
	Order by BatNbr, RefNbr
