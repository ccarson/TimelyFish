 /****** Object:  Stored Procedure dbo.AsmPlanDet_PlanId_InvtId    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.AsmPlanDet_PlanId_InvtId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc  AsmPlanDet_PlanId_InvtId @parm1 varchar ( 6), @parm2 varchar ( 30) as
       Select * from AsmPlanDet
           where PlanId  =     @parm1
             and InvtId  LIKE  @parm2
           order by PlanId,
                    InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlanDet_PlanId_InvtId] TO [MSDSL]
    AS [dbo];

