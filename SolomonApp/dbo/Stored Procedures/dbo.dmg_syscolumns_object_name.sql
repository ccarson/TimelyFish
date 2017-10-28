 create procedure dmg_syscolumns_object_name @parm1 varchar(80), @parm2 varchar(20) as

select syscolumns.id, substring(syscolumns.name,1,20) name from syscolumns
inner join sysobjects ON sysobjects.id = syscolumns.id
where sysobjects.sysstat & 0xf = 3 and sysobjects.name = @parm1 and syscolumns.name like @parm2
and syscolumns.name in (select ValidName from DMG_SoShipHeader_ValidName)
order by syscolumns.name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[dmg_syscolumns_object_name] TO [MSDSL]
    AS [dbo];

