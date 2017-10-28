 create procedure  PJBILLCH_sappdesc @parm1 varchar (16)   as
select * from PJBILLCH
where project =  @parm1  and
status <> 'C' and status <> 'P'
order by project, appnbr desc


