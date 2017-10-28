 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_PP_ApplySum AS 

select  Batnbr=(d.batnbr),
	AdjBatnbr=min(j2.adjbatnbr),
	Adjdrefnbr =min(j.adjdrefnbr),
	Adjddoctype = min(j.adjddoctype), 
	AdjAmt=sum( convert(dec(28,3),j2.AdjAmt) + convert(dec(28,3),j2.curyrgolamt)),
	CuryAdjdAmt=sum( convert(dec(28,3),j2.CuryAdjdAmt) ),
	CuryAdjgAmt=sum( convert(dec(28,3),j2.CuryAdjgAmt)),
	adjbkupwthld=sum( convert(dec(28,3),j2.adjbkupwthld) + convert(dec(28,3),j2.curyrgolamt)),
	curyadjdbkupwthld=sum( convert(dec(28,3),j2.curyadjdbkupwthld) ),
	curyadjgbkupwthld=sum( convert(dec(28,3),j2.curyadjgbkupwthld)),
	UserAddress = w.UserAddress
FROM WrkRelease w inner loop join APDoc d
ON w.batnbr = d.batnbr 
Inner join AP_PPApplic p on p.AdjdRefNbr = d.RefNbr
inner join APAdjust j
on p.PrePay_RefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP'
inner join APAdjust j2 
on j2.adjdrefnbr = d.refnbr AND j2.adjddoctype = d.doctype AND
	j.adjbatnbr = j2.adjbatnbr
WHERE d.doctype in ('VO', 'AC') and w.Module = 'AP' 
group by w.UserAddress,d.batnbr,p.prepay_refnbr




 
