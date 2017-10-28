
CREATE PROCEDURE [dbo].[pXF305_FeedOrder_Inquiry] 

	@ContactID varchar(10),
	@ordNbr varchar(10)
		
        As
	
	Select fo.* from cftFeedOrder fo 
	
	Where 
	fo.contactid = @ContactID
	and fo.status not in ('X','C')
	and fo.ordNbr like @ordNbr


	Order By OrdNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF305_FeedOrder_Inquiry] TO [MSDSL]
    AS [dbo];

