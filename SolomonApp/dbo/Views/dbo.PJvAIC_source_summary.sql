
CREATE VIEW [dbo].[PJvAIC_source_summary]
AS
-- This is part of a group of SQL tables, views, and functions used by the PJAIC_summary SQL stored procedure to
-- generate actual indirect cost amounts.

-- Dependent on: PJvPJINDSRC_summary, PJvPJACCT_IndirectGrps

select pt.alloc_calc_type,
    pt.alloc_method_cd,
    pt.alloc_method1_cd,
    pt.alloc_rate,
    amount_01 = isnull(s.amount_01, 0), amount_02 = isnull(s.amount_02, 0), amount_03 = isnull(s.amount_03, 0),
    amount_04 = isnull(s.amount_04, 0), amount_05 = isnull(s.amount_05, 0), amount_06 = isnull(s.amount_06, 0),
    amount_07 = isnull(s.amount_07, 0), amount_08 = isnull(s.amount_08, 0), amount_09 = isnull(s.amount_09, 0),
    amount_10 = isnull(s.amount_10, 0), amount_11 = isnull(s.amount_11, 0), amount_12 = isnull(s.amount_12, 0),
    amount_13 = isnull(s.amount_13, 0), amount_14 = isnull(s.amount_14, 0), amount_15 = isnull(s.amount_15, 0),
    pt.begin_step,
    pt.end_step,
    pt.fsyear_num,
    pt.from_method,
    pt.ptd_indirectgrp,
    pt.ytd_indirectgrp,
    pt.pjt_entity,
    post_acct_ptd_indirectgrp = g.ptd_indirectgrp,
    post_acct_ytd_indirectgrp = g.ytd_indirectgrp,
    pt.project,
    project_cpnyid = pt.CpnyId,
    pt.src_acct,
    pt.step_number
from (  -- Need to union the project allocation method and the second project allocation method
        select distinct p.project, t.pjt_entity, p.alloc_method_cd, alloc_method1_cd = p.alloc_method_cd, a.alloc_calc_type,
                    a.alloc_rate, a.begin_step, a.end_step, from_method = a.al_id01, a.ptd_indirectgrp, a.ytd_indirectgrp,
                    a.post_acct, a.step_number, p.CpnyId, s.fsyear_num, s.src_acct
        from PJPROJ p with (nolock)
        inner join PJPENT t with (nolock)
            on t.project = p.project
        inner join PJALLOC a with (nolock)
            on a.alloc_method_cd = p.alloc_method_cd
        -- Link to PJvINDSRC_summary without using step_number to get all the fiscal year numbers and source account cateogies possible for each step
        inner join PJvPJINDSRC_summary s with (nolock)
            on s.project = p.project
              and s.pjt_entity = t.pjt_entity
              and s.alloc_method_cd = a.alloc_method_cd
        where len(rtrim(p.alloc_method_cd)) <> 0
            and a.alloc_basis = 'A'    -- Only interested in steps based on amounts
        union
        select distinct p.project, t.pjt_entity, p.alloc_method2_cd, p.alloc_method_cd, a.alloc_calc_type,
                    a.alloc_rate, a.begin_step, a.end_step, from_method = a.al_id01, a.ptd_indirectgrp, a.ytd_indirectgrp,
                    a.post_acct, a.step_number, p.CpnyId, s.fsyear_num, s.src_acct
        from PJPROJ p with (nolock)
        inner join PJPENT t with (nolock)
            on t.project = p.project  
        inner join PJALLOC a with (nolock)
            on a.alloc_method_cd = p.alloc_method2_cd
        inner join PJvPJINDSRC_summary s with (nolock)
            on s.project = p.project
              and s.pjt_entity = t.pjt_entity
              and s.alloc_method_cd = a.alloc_method_cd
        where len(rtrim(p.alloc_method2_cd)) <> 0
            and a.alloc_basis = 'A'
    ) pt
-- Link to PJINDSRC once again, this time just to get amounts where they exists
left join PJvPJINDSRC_summary s with (nolock)
    on s.fsyear_num = pt.fsyear_num
      and s.project = pt.project
      and s.pjt_entity = pt.pjt_entity
      and s.src_acct = pt.src_acct
      and s.alloc_method_cd = pt.alloc_method_cd
      and s.step_number = pt.step_number
-- Link to get the post account category indirect groups
left join PJvPJACCT_IndirectGrps g
    on g.acct = dbo.PJfMask_acct(pt.post_acct, s.src_acct)

