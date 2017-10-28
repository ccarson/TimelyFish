 /****** Object:  Stored Procedure dbo.Update_ItemHist_BMI_BegBal2    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Update_ItemHist_BMI_BegBal2    Script Date: 4/16/98 7:41:53 PM ******/
Create Procedure Update_ItemHist_BMI_BegBal2 @parm1 float, @parm2 varchar ( 30), @parm3 varchar ( 10), @parm4 varchar ( 4) as
    UPDATE ItemBMIHist
    SET ItemBMIHist.BMIBegBal = ItemBMIHist.BMIBegBal + @parm1
    WHERE InvtId = @parm2 and
          SiteId = @parm3 and
          FiscYr > @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ItemHist_BMI_BegBal2] TO [MSDSL]
    AS [dbo];

