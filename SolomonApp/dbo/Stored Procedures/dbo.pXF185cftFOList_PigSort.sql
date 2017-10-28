CREATE PROCEDURE pXF185cftFOList_PigSort 
	@parm1 varchar (6) 
	AS 
	Update cftFOList 
	Set SortOrd = PigGroupId + OrdNbr 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOList_PigSort] TO [MSDSL]
    AS [dbo];

