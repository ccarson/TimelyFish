
create procedure [dbo].[GetViewUniqueSortEXDBProperty] @parm1 varchar (128) as
SELECT convert(char(128),value)
FROM ::fn_listextendedproperty('UniqueSort', 'User','dbo','view',
                               @parm1, default, default)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetViewUniqueSortEXDBProperty] TO [MSDSL]
    AS [dbo];

