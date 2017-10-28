 create proc WOEvent_PostPlan
	@WONbr		varchar(16)
AS

	-- First check in PJTran - if any txns then return rows - Cannot delete
	IF EXISTS (SELECT * FROM PJTran WHERE Project = @WONbr)
			-- There will always be at least one record in WOEvent for the WO - Proc Stage change
			SELECT * FROM WOEvent WHERE WONbr = @WONbr
	ELSE
   			SELECT * FROM WOEvent WHERE WONbr = @WONbr and BatchID <> ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOEvent_PostPlan] TO [MSDSL]
    AS [dbo];

