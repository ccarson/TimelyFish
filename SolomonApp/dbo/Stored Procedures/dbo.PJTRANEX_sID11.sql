 create procedure PJTRANEX_sID11 @parm1 varchar (30)   as
select * from PJTRANEX
where TR_ID11 = @parm1
	order by TR_ID11


