
CREATE PROCEDURE XDDDepositor_CustomEmail_Cnt

AS
   SELECT 	Count(*)
   FROM 	XDDDepositor (nolock)
   WHERE 	EMAttachUse = 1
		and VendCust = 'V'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_CustomEmail_Cnt] TO [MSDSL]
    AS [dbo];

