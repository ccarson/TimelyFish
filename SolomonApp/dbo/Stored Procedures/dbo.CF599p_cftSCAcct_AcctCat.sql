Create Procedure CF599p_cftSCAcct_AcctCat @parm1 varchar (16) as 
    Select * from cftSCAcct Where AcctCat Like @parm1
	Order by AcctCat
