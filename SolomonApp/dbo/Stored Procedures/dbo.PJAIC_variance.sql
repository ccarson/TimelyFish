
CREATE PROC [dbo].[PJAIC_variance] (
                @cpnyid CHAR (10),
                @period CHAR (6),
                @alloc_method_cd VARCHAR (4) = '%',
                @project VARCHAR(16) = '%') AS
-- This is part of a group of SQL tables, views, and functions used to generate actual indirect cost amounts.

-- Dependent on: PJAIC, PJvAIC_pct_variance

SET NOCOUNT ON

declare @baseCuryDecPl as smallint = (select top 1 c.DecPl from Currncy c with (nolock) where c.CuryId = (select glsetup.BaseCuryId from GLSetup with (nolock)))

-- Store actual amount in a memory TABLE variable
declare @PJAIC TABLE (
    amount_01 FLOAT, amount_02 FLOAT, amount_03 FLOAT, amount_04 FLOAT, amount_05 FLOAT,
    amount_06 FLOAT, amount_07 FLOAT, amount_08 FLOAT, amount_09 FLOAT, amount_10 FLOAT,
    amount_11 FLOAT, amount_12 FLOAT, amount_13 FLOAT, amount_14 FLOAT, amount_15 FLOAT,
    credit_cpnyid CHAR(10), credit_gl_acct CHAR(10), credit_gl_subacct CHAR(24),
    debit_cpnyid CHAR(10), debit_gl_acct CHAR(10), debit_gl_subacct CHAR(24),
    offset_acct CHAR(16), offset_pjt_entity CHAR(32), offset_project CHAR(16),
    pjt_entity CHAR(32),
    projcury_amount_01 FLOAT, projcury_amount_02 FLOAT, projcury_amount_03 FLOAT, projcury_amount_04 FLOAT, projcury_amount_05 FLOAT,
    projcury_amount_06 FLOAT, projcury_amount_07 FLOAT, projcury_amount_08 FLOAT, projcury_amount_09 FLOAT, projcury_amount_10 FLOAT,
    projcury_amount_11 FLOAT, projcury_amount_12 FLOAT, projcury_amount_13 FLOAT, projcury_amount_14 FLOAT, projcury_amount_15 FLOAT,
    projcuryid CHAR(4),
    projcurymultidiv_01 CHAR(1), projcurymultidiv_02 CHAR(1), projcurymultidiv_03 CHAR(1), projcurymultidiv_04 CHAR(1), projcurymultidiv_05 CHAR(1),
    projcurymultidiv_06 CHAR(1), projcurymultidiv_07 CHAR(1), projcurymultidiv_08 CHAR(1), projcurymultidiv_09 CHAR(1), projcurymultidiv_10 CHAR(1),
    projcurymultidiv_11 CHAR(1), projcurymultidiv_12 CHAR(1), projcurymultidiv_13 CHAR(1), projcurymultidiv_14 CHAR(1), projcurymultidiv_15 CHAR(1),
    projcuryrate_01 FLOAT, projcuryrate_02 FLOAT, projcuryrate_03 FLOAT, projcuryrate_04 FLOAT, projcuryrate_05 FLOAT,
    projcuryrate_06 FLOAT, projcuryrate_07 FLOAT, projcuryrate_08 FLOAT, projcuryrate_09 FLOAT, projcuryrate_10 FLOAT,
    projcuryrate_11 FLOAT, projcuryrate_12 FLOAT, projcuryrate_13 FLOAT, projcuryrate_14 FLOAT, projcuryrate_15 FLOAT,
    project CHAR(16),
    post_acct CHAR(16), post_pjt_entity CHAR(32), post_project CHAR(16))

-- Populate the TABLE variable based on the parameters sent
IF @alloc_method_cd = '%' or @alloc_method_cd = space(0)
    -- load up using just project (always use 'Y' YTD data)
    insert into @PJAIC
        exec PJAIC @cpnyid, @period, 'Y', @project, DEFAULT
ELSE -- load up based on projects using the allocation method criteria
BEGIN
    declare @tmp_project CHAR(16)
    declare proj_Cursor CURSOR LOCAL FAST_FORWARD
        for select distinct project
            from PJPROJ with (nolock)
            -- apply any project and the allocation method criteria
            where PJPROJ.cpnyid = @cpnyid
              and PJPROJ.project like CASE @project WHEN '%' THEN '%' WHEN space(0) THEN '%' ELSE @project END
              and (PJPROJ.alloc_method_cd like @alloc_method_cd or pjproj.alloc_method2_cd like @alloc_method_cd)
    open proj_Cursor

    -- run the PJAIC stored proc for each project to load the memory TABLE variable
    fetch next from proj_Cursor
        into @tmp_project
    while @@FETCH_STATUS = 0
    BEGIN
        insert into @PJAIC
            exec PJAIC @cpnyid, @period, 'Y', @tmp_project, DEFAULT

        fetch next from proj_Cursor
            into @tmp_project
    END
END

-- Add up all the financial periods to get a total for the year, then apply the variance percent and return the data
select amount = round(aic.amount_total * pctvar.variance_pct, @baseCuryDecPl),
    aic.credit_cpnyid, aic.credit_gl_acct, aic.credit_gl_subacct,
    aic.debit_cpnyid, aic.debit_gl_acct, aic.debit_gl_subacct,
    aic.offset_acct, aic.offset_pjt_entity, aic.offset_project,
    period = @period, aic.pjt_entity,
    projcury_amount = round(aic.projcury_amount_total * pctvar.projcury_variance_pct, projcury.DecPl),
    aic.projcuryid, aic.project,
    aic.post_acct, aic.post_pjt_entity, aic.post_project
from (select amount_total =
                 amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + 
                 amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + 
                 amount_11 + amount_12 + amount_13 + amount_14 + amount_15,
          credit_cpnyid, credit_gl_acct, credit_gl_subacct,
          debit_cpnyid, debit_gl_acct, debit_gl_subacct,
          offset_acct, offset_pjt_entity, offset_project,
          pjt_entity,
          projcury_amount_total =
                 projcury_amount_01 + projcury_amount_02 + projcury_amount_03 + projcury_amount_04 + projcury_amount_05 + 
                 projcury_amount_06 + projcury_amount_07 + projcury_amount_08 + projcury_amount_09 + projcury_amount_10 + 
                 projcury_amount_11 + projcury_amount_12 + projcury_amount_13 + projcury_amount_14 + projcury_amount_15,
          projcuryid,
          project,
          post_acct, post_pjt_entity, post_project
      from @pjaic) aic
inner join PJvAIC_pct_variance pctvar
  on pctvar.period = @period
    and pctvar.project = aic.project
    and pctvar.pjt_entity = aic.pjt_entity
    and pctvar.acct = aic.post_acct
inner join PJPROJ project with (nolock)
  on project.project = aic.project
inner join Currncy projcury with (nolock)
  on projcury.CuryId = project.ProjCuryId
where round(aic.amount_total * pctvar.variance_pct, @baseCuryDecPl) <> 0
order by 
    aic.project, aic.pjt_entity,
    aic.post_acct, aic.post_project, aic.post_pjt_entity,
    aic.offset_acct, aic.offset_project, aic.offset_pjt_entity,
    aic.credit_cpnyid, aic.credit_gl_acct, aic.credit_gl_subacct,
    aic.debit_cpnyid, aic.debit_gl_acct, aic.debit_gl_subacct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJAIC_variance] TO [MSDSL]
    AS [dbo];

