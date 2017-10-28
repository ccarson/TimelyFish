
CREATE    Procedure pXF100_cftFeedOrder_OrdNbr
		@parm1 As varchar(6), @parm2 AS varchar(10)
As
Select * 
from cftFeedOrder 
Where ContactID = @parm1 and OrdNbr Like @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFeedOrder_OrdNbr] TO [MSDSL]
    AS [dbo];

