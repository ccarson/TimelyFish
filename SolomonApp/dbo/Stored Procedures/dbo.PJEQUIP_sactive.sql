 create procedure PJEQUIP_sactive @parm1 varchar (10)  as
select * from PJEQUIP
where equip_id like @parm1
and status = 'A'
order by equip_id


