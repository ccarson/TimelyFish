 

create view vi_08990SelectCredits as

select adjgrefnbr = g.refnbr, g.custid, adjgdoctype = a.adjgdoctype, d.cpnyid, a.adjgperpost, adjdrefnbr = d.refnbr, 
adjddoctype = d.doctype, 

AdjAmt = (CASE 	WHEN (a.adjgdoctype = 'DA') THEN 0 
		WHEN (a.adjgdoctype = 'RP') THEN a.adjamt
		ELSE a.AdjAmt END), 

AdjDiscAmt = (CASE WHEN (a.adjgdoctype = 'DA') THEN a.adjamt ELSE a.AdjDiscAmt END),

updflag = (CASE a.adjgdoctype
		WHEN 'PA' THEN 'PA'
		WHEN 'PP' THEN 'PA'
		WHEN 'CM' THEN 'CM'
		WHEN 'SB' THEN 'CM'
		WHEN 'DA' THEN 'PA'
		WHEN 'RP' THEN 'PA'
		WHEN 'SC' THEN 'PA'
	END )

from ardoc d, ardoc g, aradjust a 

where 	
	g.custid = a.custid and
	(g.doctype = a.adjgdoctype or (g.doctype in ('PA', 'PP', 'CM') and a.adjgdoctype IN ('SB', 'DA', 'RP'))) and
	g.refnbr = a.adjgrefnbr and
	d.custid = a.custid and
	d.doctype = a.adjddoctype and
	d.refnbr = a.adjdrefnbr and
	a.adjgdoctype in ('PA', 'PP', 'CM', 'SB', 'DA', 'RP', 'SC') and g.rlsed = 1

union all

select g.refnbr, g.custid, g.doctype, g.cpnyid, g.perpost, ' ', ' ', 
AdjAmt = (Case 	When (g.doctype = 'CS') THEN g.origdocamt
		else g.docbal End),
0, 
updflag = (CASE g.doctype
		WHEN 'PA' THEN 'PA'
		WHEN 'PP' THEN 'PA'
                WHEN 'CS' THEN 'PA'
		WHEN 'CM' THEN 'CM'
		WHEN 'SB' THEN 'CM'
	END )

from ardoc g 
where g.doctype in ('PA', 'PP', 'CM', 'CS') and (g.docbal > 0 or 
(g.docbal = 0 and g.doctype = 'CS')) 
and ltrim(rtrim(g.custid)) <> ' ' and g.rlsed = 1



 
