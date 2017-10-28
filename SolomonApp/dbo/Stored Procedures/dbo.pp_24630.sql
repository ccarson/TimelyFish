 create proc pp_24630 @RI_ID smallint, @ri_where varchar(1024)
with execute as '07718158D19D4f5f9D23B55DBF5DF1'
as

declare @sri_id as varchar(6)

select @sri_id = convert(varchar(6),@ri_id)
select @ri_where = replace(@ri_where, 'wrkcmugl.','v.')
if @ri_where <> ''
	select @ri_where = ' and ('+@ri_where+')'

--  Modify the syntax to be SQL-compliant
SELECT	@ri_where = replace(@ri_where, '{', '')
SELECT  @ri_where = replace(@ri_where, '}', '')

exec(
'insert wrkcmugl (ri_id,cpnyid, curyid, doctype, refnbr, custid, vendid, docstatus, origrate, origmultdiv,
curypmtamt, origbasepmtamt, calcrate, calcmultdiv, calcbasepmtamt,
unrlgain, unrlloss, ugolacct, ugolsub)
select v.ri_id, v.cpnyid, v.curyid, v.doctype, v.refnbr, v.custid, v.vendid, v.docstatus, v.origrate, v.origmultdiv,
v.curypmtamt, v.origbasepmtamt, v.calcrate, v.calcmultdiv, v.calcbasepmtamt,
v.unrlgain, v.unrlloss, v.ugolacct, v.ugolsub
from vp_24630Wrk v
where v.ri_id = ' + @sri_id + @ri_where + '
order by v.DocType, v.RefNbr')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_24630] TO [MSDSL]
    AS [dbo];

