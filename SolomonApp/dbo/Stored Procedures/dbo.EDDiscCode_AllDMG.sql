 CREATE PROCEDURE EDDiscCode_AllDMG @SpecChgCode varchar(5) as
Select * From EDDiscCode Where SpecChgCode Like @SpecChgCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDiscCode_AllDMG] TO [MSDSL]
    AS [dbo];

