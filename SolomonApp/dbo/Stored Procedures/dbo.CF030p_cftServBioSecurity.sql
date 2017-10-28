create procedure CF030p_cftServBioSecurity
        @parm1 varchar(10)
	as
	select * from cftServBioSecurity
        where BioSecurityID like @parm1
	order by BioSecurityID
