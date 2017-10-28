 create procedure PJPTDROL_upjtbud @parm1 varchar (16)   as
Update PJPTDROL
SET total_budget_amount = 0,
ProjCury_tot_bud_amt = 0,
total_budget_units = 0
WHERE
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_upjtbud] TO [MSDSL]
    AS [dbo];

