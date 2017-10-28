 Create Procedure APTran_RefNbr_LineID
	@parm1 varchar ( 10),
	@parm2 varchar ( 3)
as
Select *
from APTran
where Refnbr = @parm1
	and LineID = @parm2


