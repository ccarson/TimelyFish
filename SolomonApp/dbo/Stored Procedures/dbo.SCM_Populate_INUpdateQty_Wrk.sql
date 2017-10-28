 CREATE PROCEDURE SCM_Populate_INUpdateQty_Wrk
	@ComputerName 	VARCHAR(21),
	@UpdatePO	SMALLINT,
	@UpdateSO	SMALLINT,
	@UpdateWD	SMALLINT,
	@UpdateWS	SMALLINT,
	@InvtIDParm	VARCHAR (30)
AS
		UPDATE INUpdateQty_Wrk
	SET 	UpdatePO = (UpdatePO | @UpdatePO),
		UpdateSO = (UpdateSO | @UpdateSO),
		UpdateWODemand = (UpdateWODemand | @UpdateWD),
		UpdateWOSupply = (UpdateWOSupply | @UpdateWS)

	WHERE	ComputerName = @ComputerName
		INSERT INTO INUpdateQty_Wrk (ComputerName, InvtID, SiteID, UpdatePO, UpdateSO, UpdateWODemand, UpdateWOSupply)
		SELECT DISTINCT @ComputerName, ItemSite.InvtID, ItemSite.SiteID,
			@UpdatePO, @UpdateSO, @UpdateWD, @UpdateWS

		FROM	ItemSite (NOLOCK)

		JOIN 	Inventory (NOLOCK)
		ON 	ItemSite.InvtID = Inventory.InvtID

		WHERE	Inventory.StkItem = 1
		  AND	ItemSite.InvtID LIKE @InvtIDParm
		  AND	NOT EXISTS
				(SELECT * FROM INUpdateQty_Wrk
				WHERE 	ComputerName = @ComputerName
				  AND	InvtID = ItemSite.InvtID
				  AND	SiteID = ItemSite.SiteID)


