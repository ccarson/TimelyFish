
CREATE FUNCTION [dbo].[PJfINDRTS] (@period CHAR (6),
                                   @ratecalctype CHAR(1))
RETURNS TABLE 
AS
-- This is part of a group of SQL tables, views, and functions used by the PJAIC SQL stored procedure to
-- generate actual indirect cost amounts.

-- Returns a table of rates for all combinations of company id and GL allocation group id for the
-- requested fiscal year (first 4 characters of period). If the rate calculation type parameter is
-- 'P' then it will return period-to-date rates, otherwise it returns year-to-date rates.

-- NOTE: This function is designed to always return a record so it can be used in a 'recursive'
-- query, which by definition will not allow left joins.

-- If ptd rates were NOT requested, it returns a table of ytd rates.
-- Else if ptd rate WERE requested, it builds records of ptd rates.
-- It adds to the table records with a blank allocation method for any combination of company id and
-- group id that does not already have rates. If the group id is blank then the period
-- rates are set to 1 (one), otherwise they're set to 0 (zero). Records with a blank group id have a
-- a special purpose in the PJAIC SQL stored procedure.

-- Dependent on: PJvPJACCT_IndirectGrps

RETURN
-- If they requested ytd rates, find the ytd rate for the requested period and pass that rate for
-- all period rate columns up to and including the requested period
select yr.allocmthd, yr.cpnyid, yr.grpid,
        rate_01 = case when substring(@period, 5, 2) < '01' then 0.0 else yr.rate_ytd end,
        rate_02 = case when substring(@period, 5, 2) < '02' then 0.0 else yr.rate_ytd end,
        rate_03 = case when substring(@period, 5, 2) < '03' then 0.0 else yr.rate_ytd end,
        rate_04 = case when substring(@period, 5, 2) < '04' then 0.0 else yr.rate_ytd end,
        rate_05 = case when substring(@period, 5, 2) < '05' then 0.0 else yr.rate_ytd end,
        rate_06 = case when substring(@period, 5, 2) < '06' then 0.0 else yr.rate_ytd end,
        rate_07 = case when substring(@period, 5, 2) < '07' then 0.0 else yr.rate_ytd end,
        rate_08 = case when substring(@period, 5, 2) < '08' then 0.0 else yr.rate_ytd end,
        rate_09 = case when substring(@period, 5, 2) < '09' then 0.0 else yr.rate_ytd end,
        rate_10 = case when substring(@period, 5, 2) < '10' then 0.0 else yr.rate_ytd end,
        rate_11 = case when substring(@period, 5, 2) < '11' then 0.0 else yr.rate_ytd end,
        rate_12 = case when substring(@period, 5, 2) < '12' then 0.0 else yr.rate_ytd end,
        rate_13 = case when substring(@period, 5, 2) < '13' then 0.0 else yr.rate_ytd end,
        rate_14 = case when substring(@period, 5, 2) < '14' then 0.0 else yr.rate_ytd end,
        rate_15 = case when substring(@period, 5, 2) < '15' then 0.0 else yr.rate_ytd end
 from PJPOOLH yr with (nolock)
 where @ratecalctype <> 'P'
  and yr.period = @period
  and yr.allocmthd = 'AY'
union
-- If they did not request ytd rates then get the corresponding ptd rate for each period rate column
select pr.allocmthd, pr.cpnyid, pr.grpid,
    sum(pr.rate_01), sum(pr.rate_02), sum(pr.rate_03), sum(pr.rate_04), sum(pr.rate_05),
    sum(pr.rate_06), sum(pr.rate_07), sum(pr.rate_08), sum(pr.rate_09), sum(pr.rate_10),
    sum(pr.rate_11), sum(pr.rate_12), sum(pr.rate_13), sum(pr.rate_14), sum(pr.rate_15)
from ( -- This query places the rates in the correct columns
        select dpr.allocmthd, dpr.cpnyid, dpr.grpid,
            rate_01 = case when substring(dpr.period, 5, 2) = '01' then dpr.rate_ptd else 0.0 end,
            rate_02 = case when substring(dpr.period, 5, 2) = '02' then dpr.rate_ptd else 0.0 end,
            rate_03 = case when substring(dpr.period, 5, 2) = '03' then dpr.rate_ptd else 0.0 end,
            rate_04 = case when substring(dpr.period, 5, 2) = '04' then dpr.rate_ptd else 0.0 end,
            rate_05 = case when substring(dpr.period, 5, 2) = '05' then dpr.rate_ptd else 0.0 end,
            rate_06 = case when substring(dpr.period, 5, 2) = '06' then dpr.rate_ptd else 0.0 end,
            rate_07 = case when substring(dpr.period, 5, 2) = '07' then dpr.rate_ptd else 0.0 end,
            rate_08 = case when substring(dpr.period, 5, 2) = '08' then dpr.rate_ptd else 0.0 end,
            rate_09 = case when substring(dpr.period, 5, 2) = '09' then dpr.rate_ptd else 0.0 end,
            rate_10 = case when substring(dpr.period, 5, 2) = '10' then dpr.rate_ptd else 0.0 end,
            rate_11 = case when substring(dpr.period, 5, 2) = '11' then dpr.rate_ptd else 0.0 end,
            rate_12 = case when substring(dpr.period, 5, 2) = '12' then dpr.rate_ptd else 0.0 end,
            rate_13 = case when substring(dpr.period, 5, 2) = '13' then dpr.rate_ptd else 0.0 end,
            rate_14 = case when substring(dpr.period, 5, 2) = '14' then dpr.rate_ptd else 0.0 end,
            rate_15 = case when substring(dpr.period, 5, 2) = '15' then dpr.rate_ptd else 0.0 end
        from PJPOOLH dpr with (nolock)
        where @ratecalctype = 'P'
         and dpr.period <= @period
         and substring(dpr.period, 1, 4) = substring(@period, 1, 4)
         and dpr.allocmthd = 'AP'
         -- Only provide ptd rates if a ptd record exists for the requested period
         and exists (select ap.*
                    from PJPOOLH ap with (nolock)
                    where ap.grpid = dpr.grpid
                     and ap.period = @period
                     and ap.cpnyid = dpr.cpnyid
                     and ap.allocmthd = 'AP')) pr
group by cpnyid, grpid, allocmthd
union
-- Tack on a proxy record with 1 or 0 for rates if there are no ptd or ytd records.
-- Allocation method is blank since these rates are not based on a GL allocation group
select space(0), proxy.CpnyId, proxy.grpid,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '01' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '02' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '03' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '04' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '05' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '06' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '07' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '08' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '09' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '10' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '11' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '12' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '13' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2) >= '14' then 1.0 else 0.0 end,
    case when proxy.grpid = space(0) and substring(@period, 5, 2)  = '15' then 1.0 else 0.0 end
 from ( -- Find all combinations of company ids used by projects and GL allocation group ids
        -- associated with rate types or project account categories used in project allocation methods
        -- excluding those that already have rates for this period.
        select distinct p.cpnyid, rt.grpid
        from PJPROJ p with (nolock)
        cross join ( -- Get a list of group ids related to rate types
                    select distinct grpid = case @ratecalctype when 'P' then a.ptd_indirectgrp else a.ytd_indirectgrp end
                    from PJALLOC a with (nolock)
                    union
                    -- Get a list of group ids related to post account categories
                    select distinct grpid = case @ratecalctype when 'P' then g.ptd_indirectgrp else g.ytd_indirectgrp end
                    from PJvPJACCT_IndirectGrps g
                    where g.acct in ( -- select post accounts that are actually used by linking steps in pjindsrc to the
                                      -- allocation method step and applying the wildcards
                                        select distinct dbo.pjfmask_acct(a.post_acct, s.src_acct)
                                        from PJINDSRC s with (nolock)
                                        inner join PJALLOC a with (nolock)
                                            on a.alloc_method_cd = s.alloc_method_cd
                                            and a.step_number = s.step_number
                                        where s.fsyear_num = LEFT(@period, 4))) rt
        -- Exclude those that have a rate (PJPOOLH) record.
        where not exists (select r.*
                            from PJPOOLH r with (nolock)
                            where r.grpid = rt.grpid
                             and r.period = @period
                             and r.cpnyid = p.cpnyid
                             and r.allocmthd = case @ratecalctype when 'P' then 'AP' else 'AY' end)) proxy


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfINDRTS] TO [MSDSL]
    AS [dbo];

