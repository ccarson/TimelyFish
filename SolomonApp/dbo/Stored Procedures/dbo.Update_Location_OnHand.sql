 Create Proc Update_Location_OnHand @parm1 varchar ( 30), @parm2 varchar ( 10) as
	Set NoCount ON
	Update Location Set QtyOnHand = 0 where
                Invtid = @parm1 and SiteId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Location_OnHand] TO [MSDSL]
    AS [dbo];

