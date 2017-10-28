
CREATE VIEW [dbo].[PJvPJINDSRC_summary]
AS
-- This is part of a group of SQL tables, views, and functions used by the PJAIC_summary SQL stored procedure to
-- generate actual indirect cost amounts.

select
    alloc_method_cd,
    amount_01 = sum(amount_01), amount_02 = sum(amount_02), amount_03 = sum(amount_03), amount_04 = sum(amount_04), amount_05 = sum(amount_05),
    amount_06 = sum(amount_06), amount_07 = sum(amount_07), amount_08 = sum(amount_08), amount_09 = sum(amount_09), amount_10 = sum(amount_10),
    amount_11 = sum(amount_11), amount_12 = sum(amount_12), amount_13 = sum(amount_13), amount_14 = sum(amount_14), amount_15 = sum(amount_15),
    fsyear_num,
    pjt_entity,
    project,
    src_acct,
    step_number
from PJINDSRC with (nolock)
group by project, pjt_entity, alloc_method_cd, src_acct, step_number, fsyear_num

