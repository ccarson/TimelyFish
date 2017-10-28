 Create Proc Update_ItemCost_OnHand @parm1 varchar ( 30), @parm2 varchar ( 10) as
	Set NoCount ON
	Delete from ItemCost where Invtid = @parm1 and SiteId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ItemCost_OnHand] TO [MSDSL]
    AS [dbo];

