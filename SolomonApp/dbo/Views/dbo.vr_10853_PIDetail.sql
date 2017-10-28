 

CREATE VIEW vr_10853_PIDetail

 AS

	SELECT 	PIDetail.*,
		CostPIID =
			CASE WHEN EXISTS(SELECT * FROM Inventory WHERE Inventory.InvtID = PIDetail.InvtID AND Inventory.ValMthd = 'S') THEN
			PIDetail.PIID ELSE
			NULL END
	FROM
		PIDetail


 
