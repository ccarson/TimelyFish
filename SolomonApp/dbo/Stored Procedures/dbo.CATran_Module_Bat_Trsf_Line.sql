 /****** Object:  Stored Procedure dbo.CATran_Module_Bat_Trsf_Line    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure CATran_Module_Bat_Trsf_Line @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3beg smallint, @parm3end smallint as
Select * from CATran where Module = @parm1 and BatNbr = @parm2
and LineNbr between @parm3beg and @parm3end and Drcr = 'C'

Order by Module, BatNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Module_Bat_Trsf_Line] TO [MSDSL]
    AS [dbo];

