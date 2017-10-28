Create View VR_AttachPOtoVO
as
select  * 
from apdoc 
where (apdoc.curyorigdocamt - CuryTaxTot00 - CuryTaxTot01 - CuryTaxTot02 - CuryTaxTot03) >  
ISNULL((
select sum(curycostvouched) from purorddet where purorddet.PurchaseType in ('GD','SE','SP','SW')  AND purorddet.refnbr = apdoc.refnbr), 0) + 
ISNULL((
select sum(curycostvouched) from POTran where POTran.PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR') and POTran.refnbr= apdoc.refnbr), 0)
 and apdoc.rlsed = '1' 
