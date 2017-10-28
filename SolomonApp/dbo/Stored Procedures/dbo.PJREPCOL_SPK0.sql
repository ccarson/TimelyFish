 create procedure PJREPCOL_SPK0  @parm1 varchar (10)   as
select * from PJREPCOL
where report_code  =     @parm1
order by report_code,
column_nbr


