 create procedure PJEQUIP_sequipid @parm1 varchar (10)  as
select * from PJEQUIP
where equip_id = @parm1
order by equip_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEQUIP_sequipid] TO [MSDSL]
    AS [dbo];

