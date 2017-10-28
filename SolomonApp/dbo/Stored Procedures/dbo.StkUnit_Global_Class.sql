 Create Procedure StkUnit_Global_Class
	@Parm1 as Varchar(6),
        @Parm2 as VarChar(6)

As

select distinct tounit
from inunit
where ((UnitType = '2' and ClassID = @Parm1)
     Or(UnitType = '1'))
  and ToUnit Like @Parm2
order by toUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StkUnit_Global_Class] TO [MSDSL]
    AS [dbo];

