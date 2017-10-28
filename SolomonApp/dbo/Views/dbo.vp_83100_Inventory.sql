 

CREATE VIEW dbo.vp_83100_Inventory
AS
	-- This view lists only products that can be placed on a Sales Order.
	SELECT *
	FROM Inventory (NOLOCK)
	WHERE TranStatusCode IN ('AC', 'NP', 'OH')


 
