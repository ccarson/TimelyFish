 /****** Object:  Stored Procedure dbo.VoidAPDoc_BatNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure VoidAPDoc_BatNbr @parm1 varchar ( 10) As
Update APDoc Set Status = 'V' Where
BatNbr = @parm1 and Status <> 'V'


