
create procedure PJPROJ_spk4 @parm1 varchar(16), @parm2 varchar(10) as
select * from PJPROJ
 where project like @parm1
   and cpnyid = @parm2
   and (status_pa = 'A' or status_pa = 'I')
   and alloc_method_cd <> space(1)
order by alloc_method_cd, alloc_method2_cd, rate_table_id, project

