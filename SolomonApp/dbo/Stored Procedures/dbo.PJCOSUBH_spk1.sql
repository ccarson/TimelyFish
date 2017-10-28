 create procedure PJCOSUBH_spk1 @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (16)  as
select * from PJCOSUBH
where
project          = @parm1 and
subcontract      = @parm2 and
change_order_num = @parm3
order by project, subcontract, change_order_num


