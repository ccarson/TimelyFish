 create procedure  PJBILLCH_sprinted @parm1 varchar (16) , @parm2 varchar (6)   as
select * from PJBILLCH
where project =     @parm1 and
appnbr  like  @parm2 and
status  =     'P'
order by project, appnbr


