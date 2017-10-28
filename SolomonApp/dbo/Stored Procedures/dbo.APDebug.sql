 CREATE PROCEDURE APDebug @BatNbr VARCHAR(10) as

delete from Wrkrelease where useraddress = 'APDebug'
delete from Wrkreleasebad where useraddress = 'APDebug'
delete from Wrk_TimeRange where useraddress = 'APDebug'
delete from Wrk_SalesTax where useraddress = 'APDebug'
delete from WRK_GLTRAN where useraddress = 'APDebug'

insert into wrkrelease (batnbr, module, useraddress)
values (@Batnbr, 'AP', 'APDebug')

exec pp_03400 'APDebug', 'APDebug'

select * from Wrkrelease where useraddress = 'APDebug'
select * from Wrkreleasebad where useraddress = 'APDebug'

delete from Wrkrelease where useraddress = 'APDebug'
delete from Wrkreleasebad where useraddress = 'APDebug'

Select 'Debug complete.'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDebug] TO [MSDSL]
    AS [dbo];

