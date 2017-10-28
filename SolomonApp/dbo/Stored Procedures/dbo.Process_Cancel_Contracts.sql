 Create Proc Process_Cancel_Contracts @parm1 char(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

--set @parm1 = '0060'
SELECT * FROM smContract c

where Status = 'C'
AND EXISTS (SELECT * FROM smBranch WHERE BranchID = @parm1)

AND
(EXists	(SELECT * FROM smContractRev
	WHERE
		smContractRev.ContractID = c.contractid AND
		smContractRev.RevFlag = 0 AND
		smContractRev.Status = 'O')
	or exists

        (SELECT * FROM smContractBill
        WHERE
                smContractBill.BillFlag = 0 AND
                smContractBill.Status = 'O' AND
                smContractBill.ContractID = c.contractid )


or exists

	(SELECT * FROM smConDiscount
	WHERE

		smConDiscount.ContractID = c.contractid )

)
