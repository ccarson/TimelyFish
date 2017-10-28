



/****** Object:  View dbo.cfvFeedbySite    Script Date: 1/20/2005 8:58:17 AM ******/

CREATE     VIEW cfvFeedbySite
	AS
	select fo.ContactID, fo.BarnNbr, fo.BinNbr, fo.DateOrd, fo.DateDel, fo.DateSched,QtyOrd, QtyDel/2000 As QtyDel
	From cftFeedOrder fo






 