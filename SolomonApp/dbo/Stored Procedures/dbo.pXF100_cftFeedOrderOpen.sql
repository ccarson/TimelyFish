
CREATE  PROCEDURE [dbo].[pXF100_cftFeedOrderOpen]
	(@ContactID varchar(6), @BarnNbr varchar(6), @OrdNbr varchar(10))
	AS 
	Select * from cftFeedOrder (Nolock)   -- 20120920 sripley added nolocks hint to eliminate deadlock events 
	WHERE ContactID = @ContactID
	AND BarnNbr = @BarnNbr
	AND Status NOT IN('C','X')
	AND OrdNbr <> @OrdNbr
	ORDER BY DateSched, BinNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFeedOrderOpen] TO [MSDSL]
    AS [dbo];

