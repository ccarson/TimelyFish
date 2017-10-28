 create procedure  PJBILLCH_sproj @parm1 varchar (16) , @parm2 varchar (6)   as
select * from PJBILLCH
where project =  @parm1 and
appnbr  like  @parm2
order by project, appnbr


