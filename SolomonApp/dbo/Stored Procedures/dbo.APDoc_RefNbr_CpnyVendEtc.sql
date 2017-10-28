	CREATE PROCEDURE APDoc_RefNbr_CpnyVendEtc @CpnyID varchar(10),  @vendorid varchar(15),@docType varchar(2), @perPost varchar(6), @refnbr varchar(10)
AS


select distinct apdoc.*
from apdoc
	where apdoc.cpnyid = @CpnyID
	AND apdoc.vendid LIKE @vendorid
	and apdoc.doctype = @docType
	and apdoc.perpost LIKE @perPost
	and (apdoc.curyorigdocamt - CuryTaxTot00 - CuryTaxTot01 - CuryTaxTot02 - CuryTaxTot03) >  ISNULL((select sum(curycostvouched) from purorddet 
                                           where purorddet.PurchaseType in ('GD','SE','SP','SW')  AND
												purorddet.refnbr = apdoc.refnbr), 0)
                                + ISNULL((select sum(curycostvouched) from POTran  
                                     where POTran.PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR')
											and POTran.refnbr= apdoc.refnbr), 0)
	and apdoc.rlsed = '1' 
	and  apdoc.RefNbr like @refnbr 
	Order By APDoc.RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_RefNbr_CpnyVendEtc] TO [MSDSL]
    AS [dbo];

