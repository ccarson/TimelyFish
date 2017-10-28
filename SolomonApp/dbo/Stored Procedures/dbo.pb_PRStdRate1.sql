 CREATE PROCEDURE pb_PRStdRate1
AS
    Declare @Retval smallint
    select @Retval=0
    if exists (select DedId from Deduction where BaseType = 'S') OR
       exists (select Union_Cd from UnionDeduct where BaseType = 'S')
        select @Retval=1
    select @Retval


