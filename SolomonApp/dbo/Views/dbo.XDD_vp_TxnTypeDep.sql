
create view XDD_vp_TxnTypeDep
AS

select 	T.EStatus, T.Selected,
	D.VendCust, D.VendID, D.VendAcct, D.FormatID, D.EntryClass, D.EntryClassCanChg, 
	D.PNStatus, D.PNDate, D.Status, D.TermDate,
	convert(varchar(10), coalesce(Y.TxnType, '')) As TxnType, 
	convert(varchar(10), coalesce(Y.DescrShort, 'SL Check')) As DescrShort, 
	convert(varchar(45), coalesce(Y.Descr, 'SL Computer Check')) As Descr,
	convert(varchar(4), coalesce(Y.EntryClass, 'SLCK')) As T_EntryClass,
	convert(smallint, coalesce(Y.TxnEmailOff, 0)) As T_TxnEmailOff,
	convert(smallint, coalesce(Y.TxnNACHA, 0)) As T_TxnNACHA,
	convert(varchar(1), coalesce(Y.DocPerRecord, ' ')) As T_DocPerRecord,
	convert(smallint, coalesce(Y.TxnPreNote, 0)) As T_TxnPreNote,
	convert(smallint, coalesce(Y.BEAcctInfoABAReqd, 0)) As T_BEAcctInfoABAReqd,
	convert(smallint, coalesce(Y.BEAcctInfoAcctReqd, 0)) As T_BEAcctInfoAcctReqd,
	convert(smallint, coalesce(Y.BEBeneAcctReqd, 0)) As T_BEBeneAcctReqd,
	convert(smallint, coalesce(Y.BEBeneBankAcctReqd, 0)) As T_BEBeneBankAcctReqd,
	convert(smallint, coalesce(Y.BEUse01, 0)) As T_BEUse01,
	convert(smallint, coalesce(Y.BEUse02, 0)) As T_BEUse02,
	convert(smallint, coalesce(Y.WireTabs, 0)) As T_WireTabs,
	convert(smallint, coalesce(Y.BEReqd01, 0)) As T_BEReqd01,
	convert(smallint, coalesce(Y.BEReqd02, 0)) As T_BEReqd02,
	convert(smallint, coalesce(Y.BEAcctInfoWireUsed, 0)) As T_BEAcctInfoWireUsed,
	convert(smallint, coalesce(Y.TxnEffDateOffset,0)) As T_TxnEffDateOffSet
FROM	XDDTxnTypeDep T LEFT OUTER JOIN XDDDepositor D 
	ON T.VendID = D.VendID and T.VendCust = D.VendCust and T.VendAcct = D.VendAcct LEFT OUTER JOIN XDDTxnType Y
	ON D.FormatID = Y.FormatID and T.EStatus = Y.EStatus
