Create Procedure CF300p_cfvBarn_BarnNbr @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from cfvBarn Where ContactId = @parm1 and BarnNbr Like @parm2
	Order by BarnNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cfvBarn_BarnNbr] TO [MSDSL]
    AS [dbo];

