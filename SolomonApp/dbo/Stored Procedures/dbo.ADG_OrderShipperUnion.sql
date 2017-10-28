 CREATE PROCEDURE ADG_OrderShipperUnion
	@CpnyID		varchar(10),
	@CreditDateFrom	smalldatetime,
	@CreditDateTo 	smalldatetime,
	@ViewOrdersOnly	smallint,
	@SiteID		varchar(10),
	@SlsperID	varchar(10),
	@Territory	varchar(10),
	@CreditMgrID	varchar(10)
AS
	-- These variables are used to create buffers for the sp result
	Declare @ApContact		varchar(60)
	Declare @APPhone		varchar(30)
	Declare @ARBal			float
	Declare @CuryTotInvc		float
	Declare @CuryPremFrtAmt		float
	Declare @CuryWholeOrdDisc	float
	Declare @Released		smallint
	Declare @ShipperID		varchar(15)
	Declare @SpecOrd		smallint
	Declare @TotOpenOrd		float
	Declare @WholeOrdDisc		float

		SELECT APContact = IsNull((SELECT top 1 Name FROM CustContact WHERE CustID = h.CustID and Type = 'A'), ''),
			APPhone = IsNull((SELECT top 1 Phone FROM CustContact WHERE CustID = h.CustID and Type = 'A'), ''),
			ARAcct, ARBal = @ARBal,
			ARSub, AuthNbr, BillAddr1, BillAddr2, BillAddrSpecial, BillAttn,
			BillCity, BillCountry, BillName, BillState, BillZip, BlktOrdNbr, BuildInvtID,
			BuildQty, BuyerID, BuyerName, Cancelled, h.CertID, CertNoteID, CmmnPct,
			ContractNbr, h.CpnyID, CreditApprDays, CreditApprLimit, h.CreditChk, CreditHold,
			CreditHoldDate, h.Crtd_DateTime, h.Crtd_Prog, h.Crtd_User, CuryEffDate, h.CuryID,
			CuryMultDiv, CuryPremFrtAmt, CuryRate, CuryRateType, CuryTotInvc,
			CuryTotLineDisc, CuryTotMerch, CuryTotMisc,
			CuryTotPmt, CuryTotTax, CuryTotTxbl, CuryWholeOrdDisc, CustGLClassID, h.CustID, CustOrdNbr,
			DateCancelled, Dept, DiscPct, Div, EDI810, EDI856, h.FOBID, FrtCollect,
			FrtTermsID, h.GeoCode, h.LanguageID, LineCntr, h.LUpd_DateTime, h.LUpd_Prog, h.LUpd_User,
			MarkFor, MiscChrgCntr, NextFunctionClass, NextFunctionID, h.NoteID, OrdDate, OrdNbr,
			PmtCntr, Priority, ProjectID, Released = @Released,
			h.S4Future01, h.S4Future02, h.S4Future03, h.S4Future04, h.S4Future05, h.S4Future06,
			h.S4Future07, h.S4Future08, h.S4Future09, h.S4Future10, h.S4Future11, h.S4Future12,
			ShipAddr1, ShipAddr2, ShipAddrID, ShipAddrSpecial,
			ShipAttn, ShipCity, ShipCmplt, ShipCountry, ShipCustID, ShipGeoCode, ShipName,
			ShipperID, ShipSiteID, ShipState, ShiptoID, ShiptoType, ShipVendID,
			ShipViaID, ShipZip, h.SiteID, SlsperID, h.SOTypeID, SpecOrd = @SpecOrd, h.Status, TaxID00, TaxID01,
			TaxID02, TaxID03, TermsID, TotCommCost, TotCost, TotInvc, TotLineDisc, TotMerch,
			TotMisc, a.TotOpenOrd, TotPmt, TotShipWght, TotTax, TotTxbl, Type = 'S',
			h.User1, h.User10, h.User2, h.User3, h.User4, h.User5, h.User6, h.User7, h.User8, h.User9,
			WeekendDelivery, WholeOrdDisc, WorkflowID, WorkflowStatus
		FROM 	SOShipHeader h
		  LEFT JOIN CustomerEDI c ON h.CustID = c.CustID
		  LEFT JOIN AR_Balances a On h.CustID = a.CustID and h.CpnyID = a.CpnyID
		  LEFT JOIN sostep s on h.cpnyid = s.cpnyid and h.sotypeid = s.sotypeid
			and h.Nextfunctionid = s.functionid and h.nextfunctionclass = s.functionclass
		WHERE 	h.Status = 'O'
		  AND 	CreditHold = 1
		  AND 	h.CpnyID = @CpnyID
		  AND 	CreditHoldDate >= @CreditDateFrom
		  AND 	CreditHoldDate < DateAdd(Day, 1, @CreditDateTo)
		  AND 	h.SiteID Like @SiteID
		  AND 	SlsperID Like @SlsperID
		  AND	c.TerritoryID like @Territory
		  AND	c.CreditMgrID like @CreditMgrID
		  AND	(select count(*) from sostep s2
			where s.cpnyid = s2.cpnyid
			and s.sotypeid = s2.sotypeid
			and s2.seq >= s.seq
			and s2.Status <> 'D'
			and s2.CreditChk = 1) > 0
			and (@ViewOrdersOnly = 2 or @ViewOrdersOnly  = 0)

		UNION

		SELECT APContact = IsNull((SELECT top 1 Name FROM CustContact WHERE CustID = h.CustID and Type = 'A'), ''),
			APPhone = IsNull((SELECT top 1 Phone FROM CustContact WHERE CustID = h.CustID and Type = 'A'), ''),
			ARAcct, ARBal = @ARBal,
			ARSub, AuthNbr, BillAddr1, BillAddr2, BillAddrSpecial, BillAttn,
			BillCity, BillCountry, BillName, BillState, BillZip, BlktOrdNbr, BuildInvtID,
			BuildQty, BuyerID, BuyerName, Cancelled, h.CertID, CertNoteID, CmmnPct,
			ContractNbr, h.CpnyID, CreditApprDays, CreditApprLimit, h.CreditChk, CreditHold,
			CreditHoldDate, h.Crtd_DateTime, h.Crtd_Prog, h.Crtd_User, CuryEffDate, h.CuryID,
			CuryMultDiv, CuryPremFrtAmt = @CuryPremFrtAmt, CuryRate, CuryRateType,
			CuryTotInvc = @CuryTotInvc, CuryTotLineDisc, CuryTotMerch, CuryTotMisc,
			CuryTotPmt, CuryTotTax, CuryTotTxbl, CuryWholeOrdDisc = @CuryWholeOrdDisc,
			CustGLClassID, h.CustID, CustOrdNbr,
			DateCancelled, Dept, DiscPct, Div, EDI810, EDI856, h.FOBID, FrtCollect,
			FrtTermsID, h.GeoCode, h.LanguageID, LineCntr, h.LUpd_DateTime, h.LUpd_Prog, h.LUpd_User,
			MarkFor, MiscChrgCntr, NextFunctionClass, NextFunctionID, h.NoteID, OrdDate, OrdNbr,
			PmtCntr, Priority, ProjectID, Released = @Released,
			h.S4Future01, h.S4Future02, h.S4Future03, h.S4Future04, h.S4Future05, h.S4Future06,
			h.S4Future07, h.S4Future08, h.S4Future09, h.S4Future10, h.S4Future11, h.S4Future12,
			ShipAddr1, ShipAddr2, ShipAddrID, ShipAddrSpecial,
			ShipAttn, ShipCity, ShipCmplt, ShipCountry, ShipCustID, ShipGeoCode, ShipName,
			ShipperID = @ShipperID, ShipSiteID, ShipState, ShiptoID, ShiptoType, ShipVendID,
			ShipViaID, ShipZip, SellingSiteID, SlsperID, h.SOTypeID,
			SpecOrd = @SpecOrd, h.Status, TaxID00, TaxID01,
			TaxID02, TaxID03, TermsID, TotCommCost, TotCost, TotOrd, TotLineDisc, TotMerch,
			TotMisc, a.TotOpenOrd, TotPmt, TotShipWght, TotTax, TotTxbl, Type = 'O',
			h.User1, h.User10, h.User2, h.User3, h.User4, h.User5, h.User6, h.User7, h.User8, h.User9,
			WeekendDelivery, WholeOrdDisc, WorkflowID, WorkflowStatus
		FROM 	SOHeader h
		  LEFT JOIN CustomerEDI c ON h.CustID = c.CustID
		  LEFT JOIN AR_Balances a On h.CustID = a.CustID and h.CpnyID = a.CpnyID
		  LEFT JOIN sostep s on h.cpnyid = s.cpnyid and h.sotypeid = s.sotypeid
			and h.Nextfunctionid = s.functionid and h.nextfunctionclass = s.functionclass
		WHERE 	h.Status = 'O'
		  AND 	CreditHold = 1
		  AND 	h.CpnyID = @CpnyID
		  AND 	CreditHoldDate >= @CreditDateFrom
		  AND 	CreditHoldDate < DateAdd(Day, 1, @CreditDateTo)
		  AND 	SellingSiteID Like @SiteID
		  AND 	SlsperID Like @SlsperID
		  AND	c.TerritoryID like @Territory
		  AND	c.CreditMgrID like @CreditMgrID
		  AND	(select count(*) from sostep s2
			where s.cpnyid = s2.cpnyid
			and s.sotypeid = s2.sotypeid
			and s2.seq >= s.seq
			and s2.Status <> 'D'
			and s2.CreditChk = 1) > 0
			and (@ViewOrdersOnly = 1 or @ViewOrdersOnly  = 0)
		ORDER BY OrdNbr, ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OrderShipperUnion] TO [MSDSL]
    AS [dbo];

