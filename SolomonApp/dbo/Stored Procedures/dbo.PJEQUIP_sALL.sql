 create procedure PJEQUIP_sALL @parm1 varchar (10)  as
select * from PJEQUIP
where equip_id like @parm1
order by equip_id


