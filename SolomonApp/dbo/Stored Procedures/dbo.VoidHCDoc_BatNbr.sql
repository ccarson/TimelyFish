 /****** Object:  Stored Procedure dbo.VoidHCDoc_BatNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure VoidHCDoc_BatNbr @parm1 varchar ( 10) As
Delete apdoc from APDoc Where BatNbr = @parm1


