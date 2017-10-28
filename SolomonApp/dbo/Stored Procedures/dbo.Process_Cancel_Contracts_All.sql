 Create Proc Process_Cancel_Contracts_All @parm1 char(10)
as

--set @parm1 = 'UEI'
SELECT * FROM smContract  c

where Status = 'C'
AND EXISTS (SELECT * FROM smBranch WHERE CpnyID = @parm1 and BranchID = c.BranchID)

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
