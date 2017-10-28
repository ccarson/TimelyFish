 create Proc InterCpny_CpnyID_Module_PV @parm1 varchar ( 10), @parm2 varchar ( 7), @parm3 varchar ( 2), @parm4 varchar ( 10) 
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
 AS
Select * from vs_InterCompany where FromCompany = @parm1 and ToCompany LIKE @parm4 and
(screen = @parm2 or (Screen = 'ALL  ' and Module = @parm3)
or (screen = 'ALL  ' and Module = '**') or (Module = 'ZZ' and @parm1 LIKE @parm4))


