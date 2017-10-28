 Create Proc Location_Sum @parm1 varchar ( 30), @parm2 varchar ( 10) as
	Set NoCount ON
	Select Sum(QtyOnHand) from
        Location where InvtId = @parm1 and SiteId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_Sum] TO [MSDSL]
    AS [dbo];

