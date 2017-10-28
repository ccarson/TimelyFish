 CREATE PROCEDURE SCM_Stock_InvtSite
	@ComputerName 	VARCHAR(21)
AS
		SELECT 	InvtID, SiteID

	FROM	INUpdateQty_Wrk

	WHERE 	ComputerName  = @ComputerName


