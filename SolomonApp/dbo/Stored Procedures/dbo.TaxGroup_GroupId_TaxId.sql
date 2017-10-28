 Create Proc TaxGroup_GroupId_TaxId @parm1 varchar ( 10), @parm2 varchar ( 10) as
Select *
from SlsTaxGrp
	left outer join SalesTax
		on SlsTaxGrp.TaxId = SalesTax.TaxId
where SlsTaxGrp.GroupId = @parm1
	and SlsTaxGrp.TaxId LIKE @parm2
	and SalesTax.TaxType = 'T'
order by SlsTaxGrp.GroupId,
	SlsTaxGrp.TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TaxGroup_GroupId_TaxId] TO [MSDSL]
    AS [dbo];

