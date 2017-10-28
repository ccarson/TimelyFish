

/****** Object:  Stored Procedure dbo.CF511_ContactId2    Script Date: 9/7/2004 1:51:15 PM ******/
CREATE    Procedure CF511_ContactId2 @parm1 varchar (6) as 
    Select * from cftContact
	Where ContactId LIKE @parm1 
	Order by ContactId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF511_ContactId2] TO [MSDSL]
    AS [dbo];

