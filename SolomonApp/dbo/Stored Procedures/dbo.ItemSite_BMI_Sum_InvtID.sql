 /****** Object:  Stored Procedure dbo.ItemSite_BMI_Sum_InvtID    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemSite_BMI_Sum_InvtID    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemSite_BMI_Sum_InvtID @parm1 varchar ( 30) as
        Select Sum(QtyOnHand), Sum(BMITotCost) from ItemSite
         where ItemSite.InvtId = @parm1
--- dfh Verify what we are doing with ItemSubst ????
---Go
---Drop Proc ItemSubst_InvtId_SubstInvtId
---Go
---Print 'Working on: Create Proc ItemSubst_InvtId_SubstInvtId @parm1, @parm2 as'
---Go
---Create Proc ItemSubst_InvtId_SubstInvtId @parm1 varchar ( 30), @parm2 varchar ( 30) as
---        Select Itemsubst.*, Inventory.* from Itemsubst, Inventory
---                 where ItemSubst.Invtid = @parm1
---                 and ItemSubst.SubstInvtId like @parm2
---                 and Inventory.Invtid = ItemSubst.SubstInvtId
---                 order by ItemSubst.Invtid, ItemSubst.SubstInvtId
---Go
---Drop Proc ItemSubst_InvtId_SubstInvtId2
---Go
---Print 'Working on: Create Proc ItemSubst_InvtId_SubstInvtId2 @parm1, @parm2 as'
---Go
---Create Proc ItemSubst_InvtId_SubstInvtId2 @parm1 varchar ( 30), @parm2 varchar ( 30) as
---            Select   Inventory.*, ItemSite.*, ItemSubst.*
---                    from ItemSubst, Inventory, ItemSite
---                    where ItemSubst.InvtId = @parm1
---                    and ItemSubst.SubstInvtId like @parm2
---                    and ItemSubst.SubstInvtId = Inventory.InvtId
---                    and Itemsubst.SubstInvtId = ItemSite.Invtid
---                    order by ItemSubst.InvtId, ItemSubst.SubstInvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_BMI_Sum_InvtID] TO [MSDSL]
    AS [dbo];

