 CREATE PROCEDURE GLDebug @BatNbr VARCHAR(10),
	@Sol_User varchar(10) as

delete from Wrkrelease where useraddress = 'GLDebug'

insert into wrkrelease (batnbr, module, useraddress)
values (@Batnbr, 'GL', 'GLDebug')

exec pp_01400 'GLDebug', @Sol_User

select * from Wrkrelease where useraddress = 'GLDebug'
select * from Wrkreleasebad where useraddress = 'GLDebug'

delete from Wrkrelease where useraddress = 'GLDebug'
delete from Wrkreleasebad where useraddress = 'GLDebug'

Select 'Debug complete.'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLDebug] TO [MSDSL]
    AS [dbo];

