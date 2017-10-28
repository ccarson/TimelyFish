 /****** Object:  Stored Procedure dbo.InTran_BMI_Sum_InvtId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.InTran_BMI_Sum_InvtId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc InTran_BMI_Sum_InvtId @parm1 varchar ( 30), @parm2 varchar ( 10) as
SELECT SUM(Qty), SUM(BMITranAmt) FROM INTran WHERE INTran.Invtid = @parm1 AND INTran.SiteId = @parm2 AND InSuffQty = 1 GROUP BY INTran.InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InTran_BMI_Sum_InvtId] TO [MSDSL]
    AS [dbo];

