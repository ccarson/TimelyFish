
CREATE Procedure pXF190RecalcGroups
	@parmord varchar(10)
As
Select *
From cftFeedOrder 
Where CF07=1 AND OrdNbr Like @parmord 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF190RecalcGroups] TO [MSDSL]
    AS [dbo];

