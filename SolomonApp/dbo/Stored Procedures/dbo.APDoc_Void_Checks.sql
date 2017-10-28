Create Procedure APDoc_Void_Checks @parm1 varchar ( 10), @parm2 varchar ( 10) as
Select * from apdoc
Where status = 'V'
and refnbr = @parm1
and BatNbr = @parm2
Order by refnbr

