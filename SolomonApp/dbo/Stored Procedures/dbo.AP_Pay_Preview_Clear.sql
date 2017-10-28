 CREATE PROCEDURE AP_Pay_Preview_Clear
	@parm1 char(21)
AS
	set nocount on
	Delete from APCheck
		WHERE S4Future02 = @parm1  and status = 'X' and batnbr < '0'

	Delete from APCheckDet
		WHERE S4Future02 = @parm1 and batnbr < '0'

