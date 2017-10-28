Create Procedure CF399p_cftTMVendor_MillId @parm1 varchar (6) as 
    Select * from cftTMVendor Where MillId Like @parm1
	Order by MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftTMVendor_MillId] TO [MSDSL]
    AS [dbo];

