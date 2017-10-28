Create Procedure CF303p_cftBarn_BarnNbr @parm1 varchar (6), @parm2 varchar (6) as 
    Select * from cftBarn Where ContactId = @parm1 and BarnNbr Like @parm2
	Order by ContactId, BarnNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftBarn_BarnNbr] TO [MSDSL]
    AS [dbo];

