CREATE PROCEDURE CF341p_cftTMVendor_MillId @parm1 varchar (6) 
	as
    	SELECT * FROM cftTMVendor 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTMVendor_MillId] TO [MSDSL]
    AS [dbo];

