 /****** Object:  Stored Procedure dbo.APTmpChk_UPDT_Bat_ChkNbr_CPrt    Script Date: 4/7/98 12:19:55 PM ******/
Create Proc  APTmpChk_UPDT_Bat_ChkNbr_CPrt @parm1 varchar ( 10), @parm2 smallint as
       Update APDoc
           Set  Selected   =   @parm2
           where BatNbr    =   @parm1
             and RefNbr    <>  ''
             and Selected  <>  @parm2


