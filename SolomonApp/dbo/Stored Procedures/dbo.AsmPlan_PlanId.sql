 /****** Object:  Stored Procedure dbo.AsmPlan_PlanId    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.AsmPlan_PlanId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc  AsmPlan_PlanId @parm1 varchar ( 6) as
       Select * from AsmPlan
           where PlanId  LIKE  @parm1
           order by PlanId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlan_PlanId] TO [MSDSL]
    AS [dbo];

