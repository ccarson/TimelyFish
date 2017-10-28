 CREATE Procedure IRRollup_Process
	@CurrentPeriod VarChar(6)
As

-- VM, 9/7/01. This procedure will insert the data into the work table
	DELETE	FROM IRWrkItemSite

	INSERT INTO IRWrkItemSite
		(	Crtd_DateTime,
			Crtd_Prog,
			Crtd_User,
			DemandQty,
			FromSiteID,
			InvtID,
			LUPD_DateTime,
			LUPD_Prog,
			LUPD_User,
			Processed,
			S4Future01,
			S4Future02,
			S4Future03,
			S4Future04,
			S4Future05,
			S4Future06,
			S4Future07,
			S4Future08,
			S4Future09,
			S4Future10,
			S4Future11,
			S4Future12,
			SiteID,
			User1,
			User10,
			User2,
			User3,
			User4,
			User5,
			User6,
			User7,
			User8,
			User9,
			tstamp
		)
	SELECT
		GETDATE() AS 'Crtd_DateTime',
		'4145000' AS 'Crtd_Prog',
		' '       AS 'Crtd_User',
		IRItemUsage.DemProjected,
		IRItemSiteReplenVar.IRTransferSiteID,
		IRItemUsage.InvtID,
		GETDATE() AS 'LUPD_DateTime',
		'4145000' AS 'LUPD_Prog',
		' '       AS 'LUPD_User',
		0         AS 'Processed',
		' '       AS 'S4Future01',
		' '       AS 'S4Future02',
		0.0       AS 'S4Future03',
		0.0       AS 'S4Future04',
		0.0       AS 'S4Future05',
		0.0       AS 'S4Future06',
		'01/01/1900' AS 'S4Future07',
		'01/01/1900' AS 'S4Future08',
		0         AS 'S4Future09',
		0         AS 'S4Future10',
		' '       AS 'S4Future11',
		' '       AS 'S4Future12',
		IRItemUsage.SiteID AS 'SiteID',
		' '       AS 'User1',
		'01/01/1900' AS 'User10',
		' '       AS 'User2',
		' '       AS 'User3',
		' '       AS 'User4',
		0.0       AS 'User5',
		0.0       AS 'User6',
		' '       AS 'User7',
		' '       AS 'User8',
		'01/01/1900' AS 'User9',
		Null AS 'tstamp'
	FROM
		IRItemUsage, IRItemSiteReplenVar
	WHERE
		IRItemUsage.InvtID = IRItemSIteReplenVar.InvtID
			AND IRItemUsage.SiteID = IRItemSiteReplenVar.SiteID
			AND IRItemUsage.Period = @CurrentPeriod

	-- The following logic processed records from the temp table and views

	Set	NoCount On
		While Exists (Select FromSiteID From IRWrkItemSite Where Processed = 0 And Len(RTrim(FromSiteID)) > 0)
	Begin

		-- Add the qty of the bottom nodes to the source qty.
		Update	IRWrkItemSite
			Set	IRWrkItemSite.DemandQty = (IRWrkItemSite.DemandQty + WrkRollup.DemandQty)
			From	IRWrkItemSite Inner Join IRWrkDemandQty_RollUp WrkRollup
				On IRWrkItemSite.InvtID = WrkRollUp.InvtID
				And IRWrkItemSite.SiteID = WrkRollUp.FromSiteID

		-- This will change the view as well. Now the bottom nodes that were processed will be
		-- dropped and the view will contain next higher level
		Update	IRWrkItemSite
			Set	IRWrkItemSite.Processed = 1
			From	IRWrkItemSite Inner Join IRWrkDemand_RollUp WrkRollup
				On IRWrkItemSite.InvtID = WrkRollUp.InvtID
				And IRWrkItemSite.SiteID = WrkRollUp.SiteID

	End

	-- Test the summed qty in the top node.
	/* Select	Processed, InvtID, SiteID, FromSiteID, DemandQty
		From	IRWrkItemSite
		Where	Processed = 0
		Order By InvtID, SiteID */

	-- Update the IRItemUsage table with the rolled-up demand
	UPDATE IRItemUsage
		SET IRItemUsage.DemRolledup = IRWrkItemSite.DemandQty
		FROM IRWrkItemSite
		WHERE IRItemUsage.InvtID = IRWrkItemSite.InvtID
			AND IRItemUsage.SiteID = IRWrkItemSite.SiteID
			AND IRItemUsage.Period = @CurrentPeriod


