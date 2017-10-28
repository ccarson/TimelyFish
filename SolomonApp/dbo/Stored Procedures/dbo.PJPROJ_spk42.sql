
create procedure PJPROJ_spk42 @MethodNumber varchar(1), @Method varchar(4), @Company varchar(10) as
If @MethodNumber = '1'
begin
	select * from PJPROJ
	 where alloc_method_cd = @Method
       and cpnyid = @Company
       and (status_pa = 'A' or  status_pa = 'I')
       and alloc_method_cd <> space(1)
	 order by alloc_method_cd, rate_table_id, project
end
Else --Method number is Both
begin
	select * from PJPROJ
	 where (alloc_method_cd = @Method or alloc_method2_cd = @Method)
       and cpnyid = @Company
       and (status_pa = 'A' or status_pa = 'I')
       and alloc_method_cd <> space(1)
	order by alloc_method_cd, alloc_method2_cd, rate_table_id, project
end

