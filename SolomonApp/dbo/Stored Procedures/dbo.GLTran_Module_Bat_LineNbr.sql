 Create Procedure GLTran_Module_Bat_LineNbr @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 integer as
Select * from GLTran
where Module = @parm1
and BatNbr = @parm2
and LineNbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Module_Bat_LineNbr] TO [MSDSL]
    AS [dbo];

