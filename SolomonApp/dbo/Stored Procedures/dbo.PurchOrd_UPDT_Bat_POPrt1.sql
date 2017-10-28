 /****** Object:  Stored Procedure dbo.PurchOrd_UPDT_Bat_POPrt1    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc  PurchOrd_UPDT_Bat_POPrt1 @parm1 varchar ( 10) as
       Update PurchOrd
           Set  PrtBatNbr      =  ''

           where PrtBatNbr     =  @parm1
             and Status = 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_UPDT_Bat_POPrt1] TO [MSDSL]
    AS [dbo];

