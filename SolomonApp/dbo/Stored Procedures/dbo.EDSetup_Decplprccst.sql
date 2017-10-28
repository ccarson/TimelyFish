 CREATE PROCEDURE EDSetup_Decplprccst AS
select Decplprccst from EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_Decplprccst] TO [MSDSL]
    AS [dbo];

