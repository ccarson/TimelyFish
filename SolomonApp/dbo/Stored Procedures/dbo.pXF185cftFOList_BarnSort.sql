CREATE PROCEDURE pXF185cftFOList_BarnSort 
	@parm1 varchar (6) 
	AS 
    	Update cftFOList 
	Set SortOrd = BarnNbr + OrdNbr 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOList_BarnSort] TO [MSDSL]
    AS [dbo];

