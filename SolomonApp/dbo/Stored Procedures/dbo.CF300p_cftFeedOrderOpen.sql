CREATE PROCEDURE dbo.CF300p_cftFeedOrderOpen
	(@ContactID varchar(6), @BarnNbr varchar(6), @OrdNbr varchar(10))
	AS 
	Select * from cftFeedOrder 
	WHERE ContactID = @ContactID
	AND BarnNbr = @BarnNbr
	AND Status NOT IN('C','X')
	AND OrdNbr <> @OrdNbr
	ORDER BY DateSched, BinNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedOrderOpen] TO [MSDSL]
    AS [dbo];

