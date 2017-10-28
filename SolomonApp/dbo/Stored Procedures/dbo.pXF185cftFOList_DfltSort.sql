CREATE PROCEDURE pXF185cftFOList_DfltSort 
	@parm1 varchar (6) 
	AS 
    	Update cftFOList 
	Set SortOrd = OrdNbr 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOList_DfltSort] TO [MSDSL]
    AS [dbo];

