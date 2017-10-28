 create procedure PJEQUIP_spk9 @parm1 varchar (250) , @parm2 varchar (10)  as
select * from PJEQUIP
where equip_id = @parm2
order by equip_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEQUIP_spk9] TO [MSDSL]
    AS [dbo];

