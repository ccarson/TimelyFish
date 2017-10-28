
CREATE PROCEDURE [dbo].[Company_all_DB]
	@DBName varchar (30),
	@CpnyID varchar( 10 )
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
	SELECT *
	FROM vs_Company
	WHERE Active = '1' and DatabaseName = @DBName and CpnyID LIKE @CpnyID 
	ORDER BY CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Company_all_DB] TO [MSDSL]
    AS [dbo];

