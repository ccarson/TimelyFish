
CREATE PROCEDURE [dbo].[PJAIC_summary]
                    @cpnyid CHAR (10),
                    @period CHAR (6),
                    @ratecalctype CHAR(1),
                    @project CHAR (16) = '%',
                    @pjt_entity CHAR (32) = '%'
AS
-- This is part of a group of SQL tables, views, and functions that together generate actual
-- indirect cost amounts.

-- The period and rate calculation type parameters are required. The other parameters allow a
-- degree of filtering. If they are passed as an empty string or DEFAULT, the all values will be
-- processed for that field. Returns a result set of calculated actual indirect costs using the
-- requested rate calculation type as of the requested period and optionally for the specified
-- project and/or task (pjt_entity).

-- Dependent on: PJfINDRTS(), PJvAIC_source_summary, PJvPJACCT_IndirectGrps

SET NOCOUNT ON

DECLARE @BaseCuryId CHAR(4)
SELECT TOP 1 @BaseCuryId = BaseCuryId FROM GLSetup with (nolock)

-- Put rates from PJfINDRTS() into a memory table since we will link to it many times.
DECLARE @PJINDRTS TABLE (
    allocmthd CHAR(2),
    cpnyid    CHAR(10),
    grpid     CHAR(6),
    rate_01   FLOAT,     rate_02   FLOAT,     rate_03   FLOAT,     rate_04   FLOAT,     rate_05   FLOAT,
    rate_06   FLOAT,     rate_07   FLOAT,     rate_08   FLOAT,     rate_09   FLOAT,     rate_10   FLOAT,
    rate_11   FLOAT,     rate_12   FLOAT,     rate_13   FLOAT,     rate_14   FLOAT,     rate_15   FLOAT)

INSERT INTO @PJINDRTS
    select * from PJfINDRTS(@period, @ratecalctype)

-- Setup a memory table for currency conversion rates.
DECLARE @PJCURYRATES TABLE (
    basecuryid          CHAR(4),
    basecurydecpl       SMALLINT,
    projcuryid          CHAR(4),
    projcurydecpl       SMALLINT,
    projcuryratetype    CHAR(6),
    projcuryrate_01     FLOAT,    projcuryrate_02     FLOAT,    projcuryrate_03     FLOAT,
    projcuryrate_04     FLOAT,    projcuryrate_05     FLOAT,    projcuryrate_06     FLOAT,
    projcuryrate_07     FLOAT,    projcuryrate_08     FLOAT,    projcuryrate_09     FLOAT,
    projcuryrate_10     FLOAT,    projcuryrate_11     FLOAT,    projcuryrate_12     FLOAT,
    projcuryrate_13     FLOAT,    projcuryrate_14     FLOAT,    projcuryrate_15     FLOAT,
    projcurymultidiv_01 CHAR(1),  projcurymultidiv_02 CHAR(1),  projcurymultidiv_03 CHAR(1),
    projcurymultidiv_04 CHAR(1),  projcurymultidiv_05 CHAR(1),  projcurymultidiv_06 CHAR(1),
    projcurymultidiv_07 CHAR(1),  projcurymultidiv_08 CHAR(1),  projcurymultidiv_09 CHAR(1),
    projcurymultidiv_10 CHAR(1),  projcurymultidiv_11 CHAR(1),  projcurymultidiv_12 CHAR(1),
    projcurymultidiv_13 CHAR(1),  projcurymultidiv_14 CHAR(1),  projcurymultidiv_15 CHAR(1))

-- Fill the @PJCURYRATES table with rates for a unique list of project currency ids and project currency rate types
DECLARE @ProjCuryId CHAR(4)
DECLARE @ProjCuryRateType CHAR(6)
DECLARE CuryIdRateType CURSOR LOCAL FAST_FORWARD FOR 
    select distinct p.ProjCuryId, p.ProjCuryRateType
    from PJPROJ p
    inner join PJvAIC_source s
    on s.project = p.project
      and len(rtrim(case @ratecalctype when 'P' then s.post_acct_ptd_indirectgrp else s.post_acct_ytd_indirectgrp end)) > 0
      and s.fsyear_num = left(@period, 4)
    where p.project like case @project when '%' then '%' when space(0) then '%' else @project end
      and p.CpnyId = @cpnyid
      and s.pjt_entity like case @pjt_entity when '%' then '%' when space(0) then '%' else @pjt_entity end
OPEN CuryIdRateType
FETCH NEXT FROM CuryIdRateType INTO @ProjCuryId, @ProjCuryRateType
-- Cycle though the id and rate types and use the PJfCURYRATES() function to fill the @PJCURYRATES table
WHILE (@@FETCH_STATUS = 0)
BEGIN
    INSERT INTO @PJCURYRATES
        select * from PJfCURYRATES(@BaseCuryId, @ProjCuryId, @ProjCuryRateType, left(@period, 4))
    FETCH NEXT FROM CuryIdRateType INTO @ProjCuryId, @ProjCuryRateType
END
CLOSE CuryIdRateType
DEALLOCATE CuryIdRateType

-- The ics (Indirect Cost Source) CTE (common table expression) table is a work table used to
-- build up all the source costs needed to calculate the actual indirect cost amounts. The
-- PJINDSRC record holds 'fixed' source costs. Based on the allocation method and step, there
-- may be 'variable' source costs that need to be generated before applying the actual rate.

;with ics_cte (
    [level],
    anchor_alloc_method_cd,
    anchor_pjt_entity,
    anchor_project,
    anchor_src_acct,
    anchor_step_number,
    from_method,    -- value is 1 if this step range applies to the projects 1st allocation method
    alloc_calc_type,
    alloc_method_cd,
    begin_step,
    end_step,
    grpid,
    step_number,
    amount_01, amount_02, amount_03, amount_04, amount_05,
    amount_06, amount_07, amount_08, amount_09, amount_10,
    amount_11, amount_12, amount_13, amount_14, amount_15,
    rate_01, rate_02, rate_03, rate_04, rate_05,
    rate_06, rate_07, rate_08, rate_09, rate_10,
    rate_11, rate_12, rate_13, rate_14, rate_15
) as (
-- Anchor query - populates the anchor members of the CTE (also defines the column types of the CTE)
select 1,
    s.alloc_method_cd,
    s.pjt_entity,
    s.project,
    s.src_acct,
    s.step_number,
    s.from_method,
    s.alloc_calc_type,
    s.alloc_method_cd,
    s.begin_step,
    s.end_step,
    indirectgrp = case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end,
    s.step_number,
    s.amount_01, s.amount_02, s.amount_03, s.amount_04, s.amount_05,
    s.amount_06, s.amount_07, s.amount_08, s.amount_09, s.amount_10,
    s.amount_11, s.amount_12, s.amount_13, s.amount_14, s.amount_15,
    -- Note we use the steps allocation rate if the step has no indirect group. This is where a problem occurs;
    -- if there is no indirect group and the step uses a rate type then the step allocation rate is probably zero.
    -- If the indirect group has not rates, then zero is used.
    rate_01 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_01 end,
    rate_02 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_02 end,
    rate_03 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_03 end,
    rate_04 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_04 end,
    rate_05 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_05 end,
    rate_06 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_06 end,
    rate_07 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_07 end,
    rate_08 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_08 end,
    rate_09 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_09 end,
    rate_10 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_10 end,
    rate_11 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_11 end,
    rate_12 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_12 end,
    rate_13 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_13 end,
    rate_14 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_14 end,
    rate_15 = case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_15 end
-- Process all allocation steps for all methods.
from PJvAIC_source_summary s
inner join @PJINDRTS r
 on r.cpnyid = s.project_CpnyId
  and r.grpid = case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end
-- Make sure the anchor data only picks up rows set to post to an account category that is
-- linked to a GL allocation group id.
where len(rtrim(case @ratecalctype when 'P' then s.post_acct_ptd_indirectgrp else s.post_acct_ytd_indirectgrp end)) > 0
  and s.fsyear_num = left(@period, 4)
  and s.project like case @project when '%' then '%' when space(0) then '%' else @project end
  and s.project_cpnyid = @cpnyid
  and s.pjt_entity like case @pjt_entity when '%' then '%' when space(0) then '%' else @pjt_entity end
union all
-- Recursive query - populates the recursive members of the CTE
    -- generates variable source amounts to add to any fixed source amounts in PJINDSRC
    -- also applies any fixed rates in 'subtotal' steps
    -- NOTE: Will not apply any table lookup rates. If the project allocation method is
    -- structured such that an actual rate is applied and subsequently a 'subtotal' step
    -- applies a table lookup rate to that steps result, this function will use 1 (one)
    -- for the rate. At this time there is no sql function to do rate table lookups.
select ics_cte.level + 1,
    ics_cte.anchor_alloc_method_cd,
    ics_cte.anchor_pjt_entity,
    ics_cte.anchor_project,
    ics_cte.anchor_src_acct,
    ics_cte.anchor_step_number,
    s.from_method,
    s.alloc_calc_type,
    s.alloc_method_cd,
    s.begin_step,
    s.end_step,
    case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end,
    s.step_number,
    s.amount_01, s.amount_02, s.amount_03, s.amount_04, s.amount_05,
    s.amount_06, s.amount_07, s.amount_08, s.amount_09, s.amount_10,
    s.amount_11, s.amount_12, s.amount_13, s.amount_14, s.amount_15,
    -- These are cumulative fields, meaning each new levels value is multiplied by the previous levels value.
    ics_cte.rate_01 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_01 end,
    ics_cte.rate_02 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_02 end,
    ics_cte.rate_03 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_03 end,
    ics_cte.rate_04 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_04 end,
    ics_cte.rate_05 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_05 end,
    ics_cte.rate_06 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_06 end,
    ics_cte.rate_07 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_07 end,
    ics_cte.rate_08 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_08 end,
    ics_cte.rate_09 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_09 end,
    ics_cte.rate_10 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_10 end,
    ics_cte.rate_11 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_11 end,
    ics_cte.rate_12 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_12 end,
    ics_cte.rate_13 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_13 end,
    ics_cte.rate_14 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_14 end,
    ics_cte.rate_15 * case when len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) = 0 then s.alloc_rate else r.rate_15 end
from PJvAIC_source_summary s
inner join @PJINDRTS r
 on r.cpnyid = s.project_CpnyId
  and r.grpid = case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end
inner join ics_cte
 on ics_cte.alloc_calc_type in ('SH', 'SP')    -- It's a subtotal step so there are potentially some variable amounts
  and ics_cte.begin_step <= s.step_number
  and ics_cte.end_step >= s.step_number
  and (case when ics_cte.from_method = 1 then s.alloc_method1_cd else ics_cte.alloc_method_cd end) = s.alloc_method_cd
  and ics_cte.anchor_pjt_entity = s.pjt_entity
  and ics_cte.anchor_project = s.project
  and ics_cte.anchor_src_acct = s.src_acct
-- For recursive lines, get any that are 'subtotal' calculation types and any that are 'calc' calculation types that
-- are linked to a GL allocation group.
where (len(rtrim(case @ratecalctype when 'P' then s.ptd_indirectgrp else s.ytd_indirectgrp end)) > 0
       or s.alloc_calc_type in ('SH', 'SP'))
  and s.fsyear_num = left(@period, 4)
)

-- Ok, now sum up and calculate the actual indirect cost amounts...and add the rate the results base on the post account category
select ics_sum.acct,
    amount_01 = round(ics_sum.amount_01, cr.basecurydecpl), amount_02 = round(ics_sum.amount_02, cr.basecurydecpl), amount_03 = round(ics_sum.amount_03, cr.basecurydecpl),
    amount_04 = round(ics_sum.amount_04, cr.basecurydecpl), amount_05 = round(ics_sum.amount_05, cr.basecurydecpl), amount_06 = round(ics_sum.amount_06, cr.basecurydecpl),
    amount_07 = round(ics_sum.amount_07, cr.basecurydecpl), amount_08 = round(ics_sum.amount_08, cr.basecurydecpl), amount_09 = round(ics_sum.amount_09, cr.basecurydecpl),
    amount_10 = round(ics_sum.amount_10, cr.basecurydecpl), amount_11 = round(ics_sum.amount_11, cr.basecurydecpl), amount_12 = round(ics_sum.amount_12, cr.basecurydecpl),
    amount_13 = round(ics_sum.amount_13, cr.basecurydecpl), amount_14 = round(ics_sum.amount_14, cr.basecurydecpl), amount_15 = round(ics_sum.amount_15, cr.basecurydecpl),
    fsyear_num = left(@period, 4), ics_sum.pjt_entity,
    projcury_amount_01 = round(abs(case when cr.projcuryrate_01 = 0 then 0 when cr.projcurymultidiv_01 = 'M' then ics_sum.amount_01 * cr.projcuryrate_01 else ics_sum.amount_01 / cr.projcuryrate_01 end), cr.projcurydecpl),
    projcury_amount_02 = round(abs(case when cr.projcuryrate_02 = 0 then 0 when cr.projcurymultidiv_02 = 'M' then ics_sum.amount_02 * cr.projcuryrate_02 else ics_sum.amount_02 / cr.projcuryrate_02 end), cr.projcurydecpl),
    projcury_amount_03 = round(abs(case when cr.projcuryrate_03 = 0 then 0 when cr.projcurymultidiv_03 = 'M' then ics_sum.amount_03 * cr.projcuryrate_03 else ics_sum.amount_03 / cr.projcuryrate_03 end), cr.projcurydecpl),
    projcury_amount_04 = round(abs(case when cr.projcuryrate_04 = 0 then 0 when cr.projcurymultidiv_04 = 'M' then ics_sum.amount_04 * cr.projcuryrate_04 else ics_sum.amount_04 / cr.projcuryrate_04 end), cr.projcurydecpl),
    projcury_amount_05 = round(abs(case when cr.projcuryrate_05 = 0 then 0 when cr.projcurymultidiv_05 = 'M' then ics_sum.amount_05 * cr.projcuryrate_05 else ics_sum.amount_05 / cr.projcuryrate_05 end), cr.projcurydecpl),
    projcury_amount_06 = round(abs(case when cr.projcuryrate_06 = 0 then 0 when cr.projcurymultidiv_06 = 'M' then ics_sum.amount_06 * cr.projcuryrate_06 else ics_sum.amount_06 / cr.projcuryrate_06 end), cr.projcurydecpl),
    projcury_amount_07 = round(abs(case when cr.projcuryrate_07 = 0 then 0 when cr.projcurymultidiv_07 = 'M' then ics_sum.amount_07 * cr.projcuryrate_07 else ics_sum.amount_07 / cr.projcuryrate_07 end), cr.projcurydecpl),
    projcury_amount_08 = round(abs(case when cr.projcuryrate_08 = 0 then 0 when cr.projcurymultidiv_08 = 'M' then ics_sum.amount_08 * cr.projcuryrate_08 else ics_sum.amount_08 / cr.projcuryrate_08 end), cr.projcurydecpl),
    projcury_amount_09 = round(abs(case when cr.projcuryrate_09 = 0 then 0 when cr.projcurymultidiv_09 = 'M' then ics_sum.amount_09 * cr.projcuryrate_09 else ics_sum.amount_09 / cr.projcuryrate_09 end), cr.projcurydecpl),
    projcury_amount_10 = round(abs(case when cr.projcuryrate_10 = 0 then 0 when cr.projcurymultidiv_10 = 'M' then ics_sum.amount_10 * cr.projcuryrate_10 else ics_sum.amount_10 / cr.projcuryrate_10 end), cr.projcurydecpl),
    projcury_amount_11 = round(abs(case when cr.projcuryrate_11 = 0 then 0 when cr.projcurymultidiv_11 = 'M' then ics_sum.amount_11 * cr.projcuryrate_11 else ics_sum.amount_11 / cr.projcuryrate_11 end), cr.projcurydecpl),
    projcury_amount_12 = round(abs(case when cr.projcuryrate_12 = 0 then 0 when cr.projcurymultidiv_12 = 'M' then ics_sum.amount_12 * cr.projcuryrate_12 else ics_sum.amount_12 / cr.projcuryrate_12 end), cr.projcurydecpl),
    projcury_amount_13 = round(abs(case when cr.projcuryrate_13 = 0 then 0 when cr.projcurymultidiv_13 = 'M' then ics_sum.amount_13 * cr.projcuryrate_13 else ics_sum.amount_13 / cr.projcuryrate_13 end), cr.projcurydecpl),
    projcury_amount_14 = round(abs(case when cr.projcuryrate_14 = 0 then 0 when cr.projcurymultidiv_14 = 'M' then ics_sum.amount_14 * cr.projcuryrate_14 else ics_sum.amount_14 / cr.projcuryrate_14 end), cr.projcurydecpl),
    projcury_amount_15 = round(abs(case when cr.projcuryrate_15 = 0 then 0 when cr.projcurymultidiv_15 = 'M' then ics_sum.amount_15 * cr.projcuryrate_15 else ics_sum.amount_15 / cr.projcuryrate_15 end), cr.projcurydecpl),
    ics_sum.projcuryid,
    cr.projcurymultidiv_01, cr.projcurymultidiv_02, cr.projcurymultidiv_03, cr.projcurymultidiv_04, cr.projcurymultidiv_05,
    cr.projcurymultidiv_06, cr.projcurymultidiv_07, cr.projcurymultidiv_08, cr.projcurymultidiv_09, cr.projcurymultidiv_10,
    cr.projcurymultidiv_11, cr.projcurymultidiv_12, cr.projcurymultidiv_13, cr.projcurymultidiv_14, cr.projcurymultidiv_15,
    cr.projcuryrate_01, cr.projcuryrate_02, cr.projcuryrate_03, cr.projcuryrate_04, cr.projcuryrate_05,
    cr.projcuryrate_06, cr.projcuryrate_07, cr.projcuryrate_08, cr.projcuryrate_09, cr.projcuryrate_10,
    cr.projcuryrate_11, cr.projcuryrate_12, cr.projcuryrate_13, cr.projcuryrate_14, cr.projcuryrate_15,
    ics_sum.project,
    ir.rate_01, ir.rate_02, ir.rate_03, ir.rate_04, ir.rate_05,
    ir.rate_06, ir.rate_07, ir.rate_08, ir.rate_09, ir.rate_10,
    ir.rate_11, ir.rate_12, ir.rate_13, ir.rate_14, ir.rate_15
from (    -- This query sums all the ics_cte amounts (fixed and variable)
        select
            acct = dbo.PJfMask_acct(a.post_acct, ics_cte.anchor_src_acct),
            amount_01 = sum(ics_cte.amount_01 * ics_cte.rate_01),
            amount_02 = sum(ics_cte.amount_02 * ics_cte.rate_02),
            amount_03 = sum(ics_cte.amount_03 * ics_cte.rate_03),
            amount_04 = sum(ics_cte.amount_04 * ics_cte.rate_04),
            amount_05 = sum(ics_cte.amount_05 * ics_cte.rate_05),
            amount_06 = sum(ics_cte.amount_06 * ics_cte.rate_06),
            amount_07 = sum(ics_cte.amount_07 * ics_cte.rate_07),
            amount_08 = sum(ics_cte.amount_08 * ics_cte.rate_08),
            amount_09 = sum(ics_cte.amount_09 * ics_cte.rate_09),
            amount_10 = sum(ics_cte.amount_10 * ics_cte.rate_10),
            amount_11 = sum(ics_cte.amount_11 * ics_cte.rate_11),
            amount_12 = sum(ics_cte.amount_12 * ics_cte.rate_12),
            amount_13 = sum(ics_cte.amount_13 * ics_cte.rate_13),
            amount_14 = sum(ics_cte.amount_14 * ics_cte.rate_14),
            amount_15 = sum(ics_cte.amount_15 * ics_cte.rate_15),
            grpid = case @ratecalctype when 'P' then g.ptd_indirectgrp else g.ytd_indirectgrp end,
            pjt_entity = ics_cte.anchor_pjt_entity,
            project = ics_cte.anchor_project,
            cpnyid = p.CpnyId,
            p.ProjCuryId,
            p.ProjCuryRateType
        from ics_cte
        inner join PJALLOC a with (nolock)
         on a.alloc_method_cd = ics_cte.anchor_alloc_method_cd
          and a.step_number = ics_cte.anchor_step_number
        inner join PJvPJACCT_IndirectGrps g
         on g.acct = dbo.PJfMask_acct(a.post_acct, ics_cte.anchor_src_acct)
        inner join PJPROJ p with (nolock)
         on p.project = ics_cte.anchor_project
        where len(rtrim(case @ratecalctype when 'P' then g.ptd_indirectgrp else g.ytd_indirectgrp end)) > 0
        group by ics_cte.anchor_project,
                ics_cte.anchor_pjt_entity,
                dbo.PJfMask_acct(a.post_acct, ics_cte.anchor_src_acct),
                case @ratecalctype when 'P' then g.ptd_indirectgrp else g.ytd_indirectgrp end,
                p.CpnyId,
                p.ProjCuryId,
                p.ProjCuryRateType) ics_sum
left join @PJINDRTS ir
 on ir.cpnyid = ics_sum.cpnyid
  and ir.grpid = ics_sum.grpid
left join @PJCURYRATES cr
 on cr.basecuryid = @BaseCuryId
  and cr.projcuryid = ics_sum.projcuryid
  and cr.projcuryratetype = ics_sum.projcuryratetype


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJAIC_summary] TO [MSDSL]
    AS [dbo];

