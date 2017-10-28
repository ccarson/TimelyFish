
create procedure PJRATE_BatchMode @parm1 varchar(6), @parm2 varchar(2), @parm3 varchar(10), @parm4 varchar(16), @parm5 char(1) as

--Get the transaction date range of the batch
declare @minTranDate smalldatetime, @maxTranDate smalldatetime
select @minTranDate = min(trans_date), @maxTranDate = max(trans_date) from PJTranWk where alloc_batch = ' ' and fiscalno = @parm1 and system_cd = @parm2 and batch_id = @parm3

--Get the potentially relavant rate table entries
select distinct r.*
 from PJRATE r (nolock)
 join PJPROJ p (nolock)
  on p.rate_table_id = r.rate_table_id
  and p.project = @parm4
 join PJALLOC a (nolock)
  on ((a.alloc_method_cd = p.alloc_method_cd)
       or (@parm5 <> '1' and a.alloc_method_cd = p.alloc_method2_cd))
   and a.rate_type_cd = r.rate_type_cd
 where r.effect_date >= @minTranDate and r.effect_date <= @maxTranDate
union
select r.*
 from pjrate r
 inner join (select r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3, max(r.effect_date) effect_date
              from PJRATE r (nolock)
              join PJPROJ p (nolock)
               on p.rate_table_id = r.rate_table_id
                and p.project = @parm4
              join PJALLOC a (nolock)
               on ((a.alloc_method_cd = p.alloc_method_cd)
                    or (@parm5 <> '1' and a.alloc_method_cd = p.alloc_method2_cd))
                and a.rate_type_cd = r.rate_type_cd
              where r.effect_date < @minTranDate
              group by r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3) l
 on r.rate_table_id = l.rate_table_id and r.rate_type_cd = l.rate_type_cd and r.rate_level = l.rate_level
  and r.rate_key_value1 = l.rate_key_value1 and r.rate_key_value2 = l.rate_key_value2 and r.rate_key_value3 = l.rate_key_value3
  and r.effect_date = l.effect_date
 order by r.rate_table_id, r.rate_type_cd, r.rate_level, r.rate_key_value1, r.rate_key_value2, r.rate_key_value3, r.effect_date desc
