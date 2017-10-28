
CREATE PROCEDURE [dbo].[CF305p_FeedOrder_Inquiry] 

	@ContactID varchar(10)
		
        As
	
	Select fo.* from cftFeedOrder fo (Nolock)   -- 20120920 sripley added nolocks hint to eliminate deadlock events
	
	Where 
	fo.contactid like ('%'+ RTrim(@ContactID) + '%')

	and fo.status not in ('X','C')


	Order By OrdNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF305p_FeedOrder_Inquiry] TO [MSDSL]
    AS [dbo];

