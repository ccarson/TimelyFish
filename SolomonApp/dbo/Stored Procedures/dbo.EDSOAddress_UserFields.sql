 Create Proc EDSOAddress_UserFields @CustId varchar(15), @ShipToId varchar(10) As
Select User1, User2, User3, User4, User5, User6, User7, User8 From SOAddress Where
CustId = @CustId And ShipToId = @ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOAddress_UserFields] TO [MSDSL]
    AS [dbo];

