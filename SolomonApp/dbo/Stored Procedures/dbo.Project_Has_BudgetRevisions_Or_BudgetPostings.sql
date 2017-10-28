
create procedure Project_Has_BudgetRevisions_Or_BudgetPostings @parm1 varchar (16) as
--Must return 1 for true or 0 for false
select case
            -- Budget Revisions
            when (select count(*) from PJREVHDR
                   where project = @parm1) > 0
            then 1
            -- Budget Postings
            when (select count(*) from  PJPTDSUM
                   where project =  @parm1
                     and (eac_amount            <> 0 or ProjCury_eac_amount  <> 0 or eac_units          <> 0
                         or fac_amount          <> 0 or ProjCury_fac_amount  <> 0 or fac_units          <> 0
                         or total_budget_amount <> 0 or ProjCury_tot_bud_amt <> 0 or total_budget_units <> 0)) > 0
            then 1
            else 0
        end as Result

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Project_Has_BudgetRevisions_Or_BudgetPostings] TO [MSDSL]
    AS [dbo];

