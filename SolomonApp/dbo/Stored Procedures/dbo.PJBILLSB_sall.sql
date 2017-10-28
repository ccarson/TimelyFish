 create procedure PJBILLSB_sall @parm1 varchar (16)   as
select * from PJBILLSB
where project =  @parm1
order by project, customer


