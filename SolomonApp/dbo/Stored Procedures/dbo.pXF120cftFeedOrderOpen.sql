
/****** Object:  Stored Procedure dbo.pXF120cftFeedOrderOpen    Script Date: 10/28/2005 8:01:02 AM ******/

/****** Object:  Stored Procedure dbo.pXF120cftFeedOrderOpen    Script Date: 10/28/2005 6:36:49 AM ******/
----------------------------------------------------------------------------------------
--	Purpose:Select the other (not order being entered) open orders for the same barn
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: @ContactID (Of site), @BarnNbr, @OrdNbr (to exclude)
----------------------------------------------------------------------------------------
CREATE   PROCEDURE pXF120cftFeedOrderOpen
	@ContactID varchar(6), @BarnNbr varchar(6), @OrdNbr varchar(10)
	AS 
	SELECT * FROM cftFeedOrder 
	WHERE ContactID = @ContactID
	AND BarnNbr = @BarnNbr
	AND Status NOT IN('C','X')
	AND OrdNbr <> @OrdNbr
	ORDER BY DateSched Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedOrderOpen] TO [MSDSL]
    AS [dbo];

