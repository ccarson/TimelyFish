 Create Proc Deduction_Contrib @parm1 varchar ( 4), @parm2 varchar ( 10), @parm3 varchar ( 10) as
       Select * from Deduction
           where CalYr     = @parm1
             and DedId     <> @parm2
             and DedId     like @parm3
             and EmpleeDed = 0
             and DedType   in ('C','F','I','R','S','T','V')
           order by DedId, CalYr


