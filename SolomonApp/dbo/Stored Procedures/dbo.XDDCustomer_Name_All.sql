
create proc XDDCustomer_Name_All
	@Name		varchar(30)
AS
SELECT * FROM Customer
WHERE Name LIKE @Name
ORDER BY Name

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCustomer_Name_All] TO [MSDSL]
    AS [dbo];

