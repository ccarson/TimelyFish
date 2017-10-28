CREATE PROCEDURE pXF185cftFOList_ProgSort 
	@parm1 varchar (6) 
	AS 
	Update cftFOList 
	Set SortOrd = Project + OrdNbr 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFOList_ProgSort] TO [MSDSL]
    AS [dbo];

