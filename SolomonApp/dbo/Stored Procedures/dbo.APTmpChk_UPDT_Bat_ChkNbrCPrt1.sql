 /****** Object:  Stored Procedure dbo.APTmpChk_UPDT_Bat_ChkNbrCPrt1    Script Date: 4/7/98 12:19:55 PM ******/
Create Proc  APTmpChk_UPDT_Bat_ChkNbrCPrt1 @parm1 varchar ( 10) as
       Update APDoc
           Set  BatNbr      =  ''      ,
                RefNbr          =  ''     ,
        Selected             =  0
           where BatNbr     =  @parm1
             and RefNbr         =  ''


