 Create Procedure ItemUsage_DemandTran_Purge @DeleteThruPeriod varchar (6)
   As
	-- Purge old records from IRItemUsage table
	DELETE
		FROM IRItemUsage
	WHERE
		Period <= @DeleteThruPeriod

	-- Purge old records from IRDemandTran
	DELETE
		FROM IRDemandTran
	WHERE
		PerPost <= @DeleteThruPeriod


