 create procedure  PJBILLCN_sProj @parm1 varchar (16)   as
select * from PJBILLCN
where project =  @parm1
order by project, appnbr, itemnbr, change_order_num


