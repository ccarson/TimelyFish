Create View dbo.vDistinctPCUploadAll
	AS
	Select  'Boar Additions' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr) as CountRows
		from PCUploadBoarAddition
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select  'Breeding Stock Additions' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadBreedStockAddition
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Breeding Stock Removals' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadBreedStockRemoval
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Breeding Transactions' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadBreedTransaction
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Breeding Stock Additions' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadBreedStockAddition
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Master Breeding List' as FormName, FarmID,FormSerialID, EventDay, TransferStatus=Case when Service1DateTransferred is null then 0 else -1 end, Service1DateTransferred, Count(RowNbr)
		from PCUploadMasterBreed Where Service1Date is not null
		Group by FarmID, FormSerialID, EventDay, Service1DateTransferred
	UNION
	Select 'Master Farrow List' as FormName, FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadMasterFarrow
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Master Wean List' as FormName,  FarmID,FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadMasterWean
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred
	UNION
	Select 'Piglet Mortality' as FormName,  FarmID,FormSerialID, EventDay, TransferStatus, DateTransferred, Count(RowNbr)
		from PCUploadPigMortCrossFoster
		Group by FarmID, FormSerialID, EventDay, TransferStatus, DateTransferred

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vDistinctPCUploadAll] TO [se\analysts]
    AS [dbo];

