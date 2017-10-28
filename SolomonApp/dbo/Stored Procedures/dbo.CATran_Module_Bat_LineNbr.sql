 /****** Object:  Stored Procedure dbo.CATran_Module_Bat_LineNbr    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure CATran_Module_Bat_LineNbr @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 integer as
Select * from CATran
where Module = @parm1
and BatNbr = @parm2
and LineNbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Module_Bat_LineNbr] TO [MSDSL]
    AS [dbo];

