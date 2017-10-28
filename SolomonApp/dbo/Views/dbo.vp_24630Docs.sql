

create view vp_24630Docs as
select r.ri_id, d.cpnyid, d.curyid, d.doctype, d.refnbr, d.custid, vendid = space(1), d.[status], d.curyrate, d.curymultdiv,
-- To get the doc balance as of the period to report, take the original amount and subtract all adjustments, then subtract the discount if it's still available as of the report date 
CuryPmtAmt = round(d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end), c.decpl), 
CalcRate = r.rate, CalcMultDiv = r.multdiv,
OrigBasePmtAmt = round(case when d.curymultdiv = 'M' then convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), d.curyrate)
			else convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), d.curyrate) end, b.decpl),
CalcBasePmtAmt = round(case when r.multdiv = 'M' then convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), r.rate)
			else convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), r.rate) end, b.decpl),
UnrlGainAcct = coalesce(o.UnrlGainAcct, c.UnrlGainAcct),
UnrlGainSub = coalesce(o.UnrlGainSub, c.UnrlGainSub),
UnrlLossAcct = coalesce(o.UnrlLossAcct, c.UnrlLossAcct),
UnrlLossSub = coalesce(o.UnrlLossSub, c.UnrlLossSub)
from 
ardoc d 
inner join currncy c on d.curyid = c.curyid
inner join vp_ShareRptCuryRate r on d.curyid = r.fromcuryid and d.curyratetype = r.ratetype
inner join rptruntime u on u.reportnbr = '24630' and r.ri_id = u.ri_id and d.cpnyid = u.cpnyid
inner join currncy b on r.tocuryid = b.curyid
left join CuryAcTb o on d.curyid = o.curyid and d.bankacct = o.adjacct
inner join vs_rptformat rf on u.reportnbr = rf.reportnbr and rtrim(u.reportformat) = rtrim(rf.formatname) and rf.displayindex = 1
left join vp_24630ARAdj j on u.ri_id = j.RI_ID and d.custid = j.CustId and d.doctype = j.AdjdDocType and d.refnbr = j.AdjdRefNbr
where
d.doctype in ('FI', 'IN', 'DM', 'CM')
and d.rlsed = 1
-- Grab docs that were entered during or before the report period and (they are not closed yet or were closed in a later period)
and d.PerPost <= u.EndPerNbr
and (rtrim(d.PerClosed) = space(0) or d.PerClosed > u.EndPerNbr)

union all

-- Add the fixed rate per project docs
-- For these, the rate is not in the rate table, it's fixed on the project record till the end of the project, so there is no ratetype on the doc
-- We will attempt to use the ratetype that would be defaulted for the payment (either from the customer or CM setup)
-- If there are no default ratetypes or the ratetype is not in the rate table, we'll calculate no gain/loss, but it will still appear on the report
select u.ri_id, d.cpnyid, d.curyid, d.doctype, d.refnbr, d.custid, vendid = space(1), d.[status], d.curyrate, d.curymultdiv,
round(d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end), c.decpl),
isnull(r.rate, d.curyrate), isnull(r.multdiv, d.curymultdiv),
round(case when d.curymultdiv = 'M' then convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), d.curyrate)
	else convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), d.curyrate) end, b.decpl),
-- If found use the rate table rates else just use the doc rates (same as OrigBasePmtAmt so no gain/loss)
round(case when isnull(r.multdiv, d.curymultdiv) = 'M' then convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), isnull(r.rate, d.curyrate))
	else convert(dec(28, 3), d.curyorigdocamt - ISNULL(j.curyadjdamt, 0) - (case when d.discdate >= u.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), isnull(r.rate, d.curyrate)) end, b.decpl),
coalesce(o.UnrlGainAcct, c.UnrlGainAcct),
coalesce(o.UnrlGainSub, c.UnrlGainSub),
coalesce(o.UnrlLossAcct, c.UnrlLossAcct),
coalesce(o.UnrlLossSub, c.UnrlLossSub)
from
ardoc d 
inner join currncy c on d.curyid = c.curyid
inner join Customer dc on d.CustId = dc.CustId
-- Since d.curyratetype is blank, use the default rate type from the customer; if none then use the AR default rate type in Currency Manager setup record
left join vp_ShareRptCuryRate r on d.curyid = r.fromcuryid and rtrim(case when rtrim(isnull(dc.CuryRateType, space(0))) <> space(0) then dc.CuryRateType else isnull((select top 1 arrttpdflt from cmsetup), space(0)) end) = r.ratetype
inner join rptruntime u on u.reportnbr = '24630' and d.cpnyid = u.cpnyid
inner join currncy b on isnull(r.tocuryid, (select top 1 basecuryid from glsetup)) = b.curyid
left join CuryAcTb o on d.curyid = o.curyid and d.bankacct = o.adjacct
inner join vs_rptformat rf on u.reportnbr = rf.reportnbr and rtrim(u.reportformat) = rtrim(rf.formatname) and rf.displayindex = 1
left join vp_24630ARAdj j on u.ri_id = j.RI_ID and d.custid = j.CustId and d.doctype = j.AdjdDocType and d.refnbr = j.AdjdRefNbr
where
d.doctype in ('FI', 'IN', 'DM', 'CM')
and d.rlsed = 1
-- These docs will have a blank d.curyratetype and from-currency is not the gl base currency
and d.curyratetype = space(0)
and d.curyid != (select top 1 basecuryid from glsetup)
and d.PerPost <= u.EndPerNbr
and (rtrim(d.PerClosed) = space(0) or d.PerClosed > u.EndPerNbr)

union all

select r.ri_id, d.cpnyid, d.curyid, d.doctype, d.refnbr, space(0), d.vendid, d.[status], d.curyrate, d.curymultdiv,
round(d.CuryOrigDocAmt - ISNULL(j.CuryAdjdAmt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end), c.decpl),
r.rate, r.multdiv,
round(case when d.curymultdiv = 'M' then convert(dec(28, 3), d.CuryOrigDocAmt - ISNULL(j.CuryAdjdAmt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), d.curyrate)
	else convert(dec(28, 3), d.CuryOrigDocAmt - ISNULL(j.CuryAdjdAmt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), d.curyrate) end, b.decpl),
round(case when r.multdiv = 'M' then convert(dec(28, 3), d.CuryOrigDocAmt - ISNULL(j.CuryAdjdAmt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) * convert(dec(19, 9), r.rate)
	else convert(dec(28, 3), d.CuryOrigDocAmt - ISNULL(j.CuryAdjdAmt, 0) - (case when d.discdate >= r.reportdate then d.curydiscbal else 0 end)) / convert(dec(19, 9), r.rate) end, b.decpl),
coalesce(o.UnrlGainAcct, c.UnrlGainAcct),
coalesce(o.UnrlGainSub, c.UnrlGainSub),
coalesce(o.UnrlLossAcct, c.UnrlLossAcct),
coalesce(o.UnrlLossSub, c.UnrlLossSub)
from 
apdoc d 
inner join currncy c on d.curyid = c.curyid
inner join vp_ShareRptCuryRate r on d.curyid = r.fromcuryid and d.curyratetype = r.ratetype
inner join rptruntime u on r.ri_id = u.ri_id and d.cpnyid = u.cpnyid and u.reportnbr = '24630'
inner join currncy b on r.tocuryid = b.curyid
left join CuryAcTb o on d.curyid = o.curyid and d.acct = o.adjacct
inner join vs_rptformat rf on u.reportnbr = rf.reportnbr and rtrim(u.reportformat) = rtrim(rf.formatname) and rf.displayindex = 0
left join vp_24630APAdj j on u.ri_id = j.RI_ID and d.refnbr = j.AdjdRefNbr and d.doctype = j.AdjdDocType and d.vendid = j.VendId
where
d.doctype in ('AC', 'AD', 'VO')
and d.rlsed = 1
and d.selected = 0
and d.PerPost <= u.EndPerNbr
and (rtrim(d.PerClosed) = space(0) or d.PerClosed > u.EndPerNbr)


