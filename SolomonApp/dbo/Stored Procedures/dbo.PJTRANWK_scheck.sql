 create procedure PJTRANWK_scheck @parm1 varchar(6) as
select * from PJTRANWK
where fiscalno <= @parm1


