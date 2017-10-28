 /****** Object:  Stored Procedure dbo.ItemCost_Sum    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemCost_Sum    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemCost_Sum @parm1 varchar ( 30), @parm2 varchar (  10),  @parm3 varchar ( 15) as
Select Sum(Qty), Sum(TotCost), Sum(BMITotCost) from
        ItemCost where InvtId = @parm1 and SiteId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_Sum] TO [MSDSL]
    AS [dbo];

