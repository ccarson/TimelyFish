 create procedure  PJBILLCN_spk0 @parm1 varchar (16) , @parm2 varchar (6) , @parm3 varchar (6) , @parm4 varchar (16)   as
select * from PJBILLCN
where project =  @parm1 and
appnbr  =  @parm2 and
itemnbr  like  @parm3 and
change_order_num like  @parm4
order by project, appnbr, itemnbr, change_order_num


