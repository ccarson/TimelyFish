Create Procedure CF518p_cftPSContract_CtrctNbr @parm1 varchar (10) as 
    Select * from cftPSContract Where CtrctNbr Like @parm1
	Order by CtrctNbr
