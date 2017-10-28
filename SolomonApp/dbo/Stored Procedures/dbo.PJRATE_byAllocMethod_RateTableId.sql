
create procedure PJRATE_byAllocMethod_RateTableId @cpnyid varchar(10), @project varchar(16), @methodnum char(1), @method varchar(4), @method2 varchar(4),
                                                  @ratetableid varchar(4), @subacct varchar(24), @recalc char(1), @period char(6), @cutoffdate smalldatetime,
                                                  @startdate smalldatetime, @enddate smalldatetime, @startperiod char(6), @endperiod char(6) as

--Get the transaction date range in pjtran based on the rate table and alloc methods now active...as well as the other user entered filters
declare @minTranDate smalldatetime, @maxTranDate smalldatetime
select @minTranDate = min(t.trans_date), @maxTranDate = max(t.trans_date)
 from pjtran t with (nolock)
 inner join pjproj p with (nolock)
    on p.project = t.project
    and p.CpnyId = @cpnyid
    and p.rate_table_id = @ratetableid
    and (p.alloc_method_cd = @method
         or (@methodnum <> '1' and p.alloc_method2_cd = @method2))
    and p.gl_subacct like case when len(rtrim(@subacct)) = 0 then '%' else @subacct end
    and (p.status_pa = 'A' or status_pa = 'I')
    and p.alloc_method_cd <> space(0)
 where t.project like case when len(rtrim(@project)) = 0 then '%' else @project end
   and ((@recalc <> 'Y'
            and batch_type <> 'ALLC'
            and alloc_flag = space(0)
            and fiscalNo = @period
            and trans_date <= @cutoffdate)
        or (@recalc = 'Y'
            and t.alloc_flag <> 'X'
            and t.fiscalno >= @startperiod and t.fiscalno <= @endperiod
            and t.trans_date >= @startdate and t.trans_date <= @enddate))

--Get the potentially relavant rate table entries
select distinct r.*
 from PJRATE r (nolock)
 join PJALLOC a (nolock)
  on a.rate_type_cd = r.rate_type_cd
   and ((a.alloc_method_cd = @method)
       or (@methodnum <> '1' and a.alloc_method_cd = @method2))
 where r.rate_table_id = @ratetableid and r.effect_date >= @minTranDate and r.effect_date <= @maxTranDate
union
select r.*
 from pjrate r
 inner join (select r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3, max(r.effect_date) effect_date
              from PJRATE r (nolock)
              join PJALLOC a (nolock)
               on a.rate_type_cd = r.rate_type_cd
                and ((rtrim(a.alloc_method_cd) = rtrim(@method))
                    or (@methodnum <> '1' and rtrim(a.alloc_method_cd) = rtrim(@method2)))
              where r.rate_table_id = @ratetableid and r.effect_date < @minTranDate
              group by r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3) l
 on r.rate_table_id = l.rate_table_id and r.rate_type_cd = l.rate_type_cd and r.rate_level = l.rate_level
  and r.rate_key_value1 = l.rate_key_value1 and r.rate_key_value2 = l.rate_key_value2 and r.rate_key_value3 = l.rate_key_value3
  and r.effect_date = l.effect_date
 order by r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3, r.effect_date desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_byAllocMethod_RateTableId] TO [MSDSL]
    AS [dbo];

