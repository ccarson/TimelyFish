 create procedure  PJBILLCH_sneqstatus @parm1 varchar (16) , @parm2 varchar (1)   as
select * from PJBILLCH
where project =     @parm1 and
status  <>     @parm2
order by project, appnbr


