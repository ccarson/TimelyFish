 create procedure PJCOSUBH_SSUBSTAT  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (1)   as
select * from PJCOSUBH
where
PJCOSUBH.project            =    @parm1 and
PJCOSUBH.subcontract        =    @parm2 and
PJCOSUBH.status1            LIKE @parm3
order by PJCOSUBH.project,
PJCOSUBH.subcontract,
PJCOSUBH.change_order_num


