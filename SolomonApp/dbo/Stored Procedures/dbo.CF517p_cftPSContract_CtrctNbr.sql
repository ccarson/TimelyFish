Create Procedure CF517p_cftPSContract_CtrctNbr @parm1 varchar (10) as 
    Select * from cftPSContract Where CtrctNbr Like @parm1
	Order by CtrctNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF517p_cftPSContract_CtrctNbr] TO [MSDSL]
    AS [dbo];

