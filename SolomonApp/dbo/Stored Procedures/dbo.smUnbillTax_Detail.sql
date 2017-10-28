
Create Proc smUnbillTax_Detail
@taxID varchar (10),
@callID varchar (10) as

SELECT Sum(TaxAmt00), Sum(TxblAmt00) 
FROM smServDetail
WHERE TaxID00 = @taxID
	AND ServiceCallID =  @callID
	AND BillFlag = '0'
	AND TaxExempt = 'N'
