
CREATE PROCEDURE XDDDepositor_VendAcct
  @parm1      	varchar(15),
  @parm2	varchar(10)

AS
  Select      	*
  FROM        	XDDDepositor
  WHERE       	VendCust = 'V'
		and VendID = @parm1
		and VendAcct LIKE @parm2
  ORDER BY    	VendID, VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_VendAcct] TO [MSDSL]
    AS [dbo];

