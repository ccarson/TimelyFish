 /****** Object:  Stored Procedure dbo.ItemSite_Sum_InvtId    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemSite_Sum_InvtId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemSite_Sum_InvtId @parm1 varchar ( 30) as
        Select Sum(QtyOnHand), Sum(TotCost) from ItemSite
         where ItemSite.InvtId = @parm1


