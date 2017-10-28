

-- ===================================================================
-- Author:  Andrey Derco
-- Create date: 11/28/2008
-- Description: Selects data for % Position Coverage report
-- ===================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-09-15  Doran Dahle Removed the CPI.Balance for Mill 102.  Gemini Ticket CORNPURCH-2085    
2011-09-15  Doran Dahle Removed the CPI.Balance for Mill 109.  Gemini Ticket CORNPURCH-2085    
2011-09-15  Doran Dahle Set the Else to 0  for the ReminderSD.  Gemini Ticket CORNPURCH-2085 
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_PERCENT_POSITION_COVERAGE]
(
    @CommodityID	int

)
AS
BEGIN
SET NOCOUNT ON;



DECLARE @Dates TABLE
(
  MonthYear 		int not null,
  ProjectedUsage101	decimal(20,4) null,
  Owned101		decimal(20,4) null,
  Basis101		decimal(20,4) null,
  ProjectedUsage102	decimal(20,4) null,
  Owned102		decimal(20,4) null,
  Basis102		decimal(20,4) null,
  ProjectedUsage104	decimal(20,4) null,
  Owned104		decimal(20,4) null,
  Basis104		decimal(20,4) null,
  ProjectedUsage109	decimal(20,4) null,
  Owned109		decimal(20,4) null,
  Basis109		decimal(20,4) null,
  ProjectedUsageSD	decimal(20,4) null,
  OwnedSD		decimal(20,4) null,
  BasisSD		decimal(20,4) null  
)

DECLARE @MNContingentOfferContractTypeID int,
        @IAContingentOfferContractTypeID int,
        @MNPriceLaterContractTypeID int,
        @IACreditSaleContractTypeID int


SELECT @MNContingentOfferContractTypeID = 1,
       @IAContingentOfferContractTypeID = 23,
       @MNPriceLaterContractTypeID = 20,
       @IACreditSaleContractTypeID  = 25


DECLARE @StartMonthYear			int,
        @EndMonthYear 			int,
        @MaxContractMonthYear		int,
        @MaxProjectedUsageMonthYear	int,
        @Reminder101			decimal(20,4),
        @ProjectedUsage101		decimal(10,0),
        @Owned101			decimal(20,4),
        @Basis101			decimal(20,4),
        @Reminder102			decimal(20,4),
        @ProjectedUsage102		decimal(20,4),
        @Owned102			decimal(20,4),
        @Basis102			decimal(20,4),
        @Reminder104			decimal(20,4),
        @ProjectedUsage104		decimal(20,4),
        @Owned104			decimal(20,4),
        @Basis104			decimal(20,4),
        @Reminder109			decimal(20,4),
        @ProjectedUsage109		decimal(20,4),
        @Owned109			decimal(20,4),
        @Basis109			decimal(20,4),
        @ReminderSD			decimal(20,4),
        @ProjectedUsageSD		decimal(20,4),
        @OwnedSD			decimal(20,4),
        @BasisSD			decimal(20,4)
       

SELECT @StartMonthYear = year(getdate()) * 100 + month(getdate())


SELECT @MaxContractMonthYear = max(DeliveryMonth) 
FROM dbo.CFT_CONTRACT
WHERE CommodityID = @CommodityID 
      AND ContractStatusID NOT IN (2, 3)
      AND dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) > 0

SELECT @MaxProjectedUsageMonthYear = max(Year * 100 + Month)
FROM dbo.cft_PROJECTED_USAGE


SELECT @EndMonthYear = CASE WHEN @MaxContractMonthYear > @MaxProjectedUsageMonthYear THEN @MaxContractMonthYear ELSE @MaxProjectedUsageMonthYear END


SELECT @Reminder101 = CPI.Balance 
FROM dbo.cft_CORN_PURCHASING_INVENTORY CPI
INNER JOIN  (
                   SELECT MAX(InventoryDate) AS InventoryDate
                   FROM dbo.cft_CORN_PURCHASING_INVENTORY 
                   WHERE InventoryDate <= convert(varchar,getdate(),101)
                         AND FeedMillID = '101' AND CommodityID = @CommodityID
            ) AS CPI1 ON CPI.InventoryDate = CPI1.InventoryDate
WHERE CPI.FeedMillID = '101' AND CommodityID = @CommodityID

SELECT @Reminder102 = 0
/* CPI.Balance 
FROM dbo.cft_CORN_PURCHASING_INVENTORY CPI
INNER JOIN  (
                   SELECT MAX(InventoryDate) AS InventoryDate
                   FROM dbo.cft_CORN_PURCHASING_INVENTORY 
                   WHERE InventoryDate <= convert(varchar,getdate(),101)
                         AND FeedMillID = '102' AND CommodityID = @CommodityID
            ) AS CPI1 ON CPI.InventoryDate = CPI1.InventoryDate
WHERE CPI.FeedMillID = '102' AND CommodityID = @CommodityID
*/
SELECT @Reminder104 = CPI.Balance 
FROM dbo.cft_CORN_PURCHASING_INVENTORY CPI
INNER JOIN  (
                   SELECT MAX(InventoryDate) AS InventoryDate
                   FROM dbo.cft_CORN_PURCHASING_INVENTORY 
                   WHERE InventoryDate <= convert(varchar,getdate(),101)
                         AND FeedMillID = '104' AND CommodityID = @CommodityID
            ) AS CPI1 ON CPI.InventoryDate = CPI1.InventoryDate
WHERE CPI.FeedMillID = '104' AND CommodityID = @CommodityID

SELECT @Reminder109 = 0
/* CPI.Balance 
FROM dbo.cft_CORN_PURCHASING_INVENTORY CPI
INNER JOIN  (
                   SELECT MAX(InventoryDate) AS InventoryDate
                   FROM dbo.cft_CORN_PURCHASING_INVENTORY 
                   WHERE InventoryDate <= convert(varchar,getdate(),101)
                         AND FeedMillID = '109' AND CommodityID = @CommodityID
            ) AS CPI1 ON CPI.InventoryDate = CPI1.InventoryDate
WHERE CPI.FeedMillID = '109' AND CommodityID = @CommodityID
*/
SELECT @ReminderSD = CPI.Balance 
FROM dbo.cft_CORN_PURCHASING_INVENTORY CPI
INNER JOIN  (
                   SELECT MAX(InventoryDate) AS InventoryDate
                   FROM dbo.cft_CORN_PURCHASING_INVENTORY 
                   WHERE InventoryDate <= convert(varchar,getdate(),101)
                         AND FeedMillID = 'SD' AND CommodityID = @CommodityID
            ) AS CPI1 ON CPI.InventoryDate = CPI1.InventoryDate
WHERE CPI.FeedMillID = 'SD' AND CommodityID = @CommodityID


 SELECT @Reminder101 = @Reminder101 + SUM(CASE WHEN FeedMillID = '101' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Reminder102 = @Reminder102 + SUM(CASE WHEN FeedMillID = '102' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Reminder104 = @Reminder104 + SUM(CASE WHEN FeedMillID = '104' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Reminder109 = @Reminder109 + SUM(CASE WHEN FeedMillID = '109' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @ReminderSD  = @ReminderSD  + SUM(CASE WHEN FeedMillID = 'SD' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END)
 FROM dbo.cft_CONTRACT
 WHERE DeliveryMonth < @StartMonthYear 
       AND CommodityID = @CommodityID 
       AND ContractStatusID NOT IN (2, 3)
       AND ContractTypeID NOT IN (@MNContingentOfferContractTypeID, @IAContingentOfferContractTypeID)

 
WHILE @StartMonthYear <= @EndMonthYear BEGIN 


 SELECT @ProjectedUsage101 = AVG(CASE WHEN FeedMillID = '101' THEN ProjectedUsage ELSE NULL END),
        @ProjectedUsage102 = AVG(CASE WHEN FeedMillID = '102' THEN ProjectedUsage ELSE NULL END),
        @ProjectedUsage104 = AVG(CASE WHEN FeedMillID = '104' THEN ProjectedUsage ELSE NULL END),
        @ProjectedUsage109 = AVG(CASE WHEN FeedMillID = '109' THEN ProjectedUsage ELSE NULL END),
        @ProjectedUsageSD = AVG(CASE WHEN FeedMillID = 'SD' THEN ProjectedUsage ELSE NULL END)
 FROM dbo.cft_PROJECTED_USAGE 
 WHERE Month = right(@StartMonthYear,2) AND Year = left(@StartMonthYear,4)

 SELECT @Owned101 = SUM(CASE WHEN FeedMillID = '101' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Basis101 = SUM(CASE WHEN FeedMillID = '101' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels * ISNULL(FuturesBasis,PricedBasis) ELSE 0 END) / 
                      CASE WHEN SUM(CASE WHEN FeedMillID = '101' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) = 0 THEN 1 ELSE
                        SUM(CASE WHEN FeedMillID = '101' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) END,

        @Owned102 = SUM(CASE WHEN FeedMillID = '102' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Basis102 = SUM(CASE WHEN FeedMillID = '102' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels * ISNULL(FuturesBasis,PricedBasis) ELSE 0 END) / 
                      CASE WHEN SUM(CASE WHEN FeedMillID = '102' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) = 0 THEN 1 ELSE
                        SUM(CASE WHEN FeedMillID = '102' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) END,

        @Owned104 = SUM(CASE WHEN FeedMillID = '104' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Basis104 = SUM(CASE WHEN FeedMillID = '104' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels * ISNULL(FuturesBasis,PricedBasis) ELSE 0 END) / 
                      CASE WHEN SUM(CASE WHEN FeedMillID = '104' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) = 0 THEN 1 ELSE
                        SUM(CASE WHEN FeedMillID = '104' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) END,

        @Owned109 = SUM(CASE WHEN FeedMillID = '109' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @Basis109 = SUM(CASE WHEN FeedMillID = '109' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels * ISNULL(FuturesBasis,PricedBasis) ELSE 0 END) / 
                      CASE WHEN SUM(CASE WHEN FeedMillID = '109' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) = 0 THEN 1 ELSE
                        SUM(CASE WHEN FeedMillID = '109' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) END,

        @OwnedSD = SUM(CASE WHEN FeedMillID = 'SD' THEN dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(ContractID) ELSE 0 END),
        @BasisSD = SUM(CASE WHEN FeedMillID = 'SD' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels * ISNULL(FuturesBasis,PricedBasis) ELSE 0 END) / 
                      CASE WHEN SUM(CASE WHEN FeedMillID = 'SD' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) = 0 THEN 1 ELSE
                        SUM(CASE WHEN FeedMillID = 'SD' AND NOT(FuturesBasis IS NULL AND PricedBasis IS NULL) AND ContractTypeID <> @MNPriceLaterContractTypeID THEN Bushels ELSE 0 END) END

 FROM dbo.cft_CONTRACT
 WHERE DeliveryMonth = @StartMonthYear 
       AND CommodityID = @CommodityID 
       AND ContractStatusID NOT IN (2, 3)
       AND ContractTypeID NOT IN (@MNContingentOfferContractTypeID, @IAContingentOfferContractTypeID)


  INSERT @Dates
  VALUES
  (
     @StartMonthYear,
     @ProjectedUsage101,
     ISNULL(@Owned101, 0) + ISNULL(@Reminder101, 0),
     @Basis101,

     @ProjectedUsage102,
     ISNULL(@Owned102, 0) + ISNULL(@Reminder102, 0),
     @Basis102,

     @ProjectedUsage104,
     ISNULL(@Owned104, 0) + ISNULL(@Reminder104, 0),
     @Basis104,

     @ProjectedUsage109,
     ISNULL(@Owned109, 0) + ISNULL(@Reminder109, 0),
     @Basis109,

     @ProjectedUsageSD,
     ISNULL(@OwnedSD, 0) + ISNULL(@ReminderSD, 0),
     @BasisSD
  )

  SELECT @Reminder101 = CASE WHEN ISNULL(@Owned101, 0) + ISNULL(@Reminder101, 0) > ISNULL(@ProjectedUsage101, 0) AND @ProjectedUsage101 IS NOT NULL THEN ISNULL(@Owned101, 0) + ISNULL(@Reminder101, 0) - ISNULL(@ProjectedUsage101, 0) ELSE 0 END,
         @Reminder102 = CASE WHEN ISNULL(@Owned102, 0) + ISNULL(@Reminder102, 0) > ISNULL(@ProjectedUsage102, 0) AND @ProjectedUsage102 IS NOT NULL THEN ISNULL(@Owned102, 0) + ISNULL(@Reminder102, 0) - ISNULL(@ProjectedUsage102, 0) ELSE 0 END,
         @Reminder104 = CASE WHEN ISNULL(@Owned104, 0) + ISNULL(@Reminder104, 0) > ISNULL(@ProjectedUsage104, 0) AND @ProjectedUsage104 IS NOT NULL THEN ISNULL(@Owned104, 0) + ISNULL(@Reminder104, 0) - ISNULL(@ProjectedUsage104, 0) ELSE 0 END,
         @Reminder109 = CASE WHEN ISNULL(@Owned109, 0) + ISNULL(@Reminder109, 0) > ISNULL(@ProjectedUsage109, 0) AND @ProjectedUsage109 IS NOT NULL THEN ISNULL(@Owned109, 0) + ISNULL(@Reminder109, 0) - ISNULL(@ProjectedUsage109, 0) ELSE 0 END,
         @ReminderSD = CASE WHEN ISNULL(@OwnedSD, 0) + ISNULL(@ReminderSD, 0) > ISNULL(@ProjectedUsageSD, 0) AND @ProjectedUsageSD IS NOT NULL THEN ISNULL(@OwnedSD, 0) + ISNULL(@ReminderSD, 0) - ISNULL(@ProjectedUsageSD, 0) ELSE 0 END
        -- @ReminderSD = CASE WHEN ISNULL(@OwnedSD, 0) + ISNULL(@ReminderSD, 0) > ISNULL(@ProjectedUsageSD, 0) AND @ProjectedUsageSD IS NOT NULL THEN ISNULL(@OwnedSD, 0) + ISNULL(@ReminderSD, 0) - ISNULL(@ProjectedUsageSD, 0) ELSE ISNULL(@OwnedSD, 0) END

  IF right(@StartMonthYear,2) = 12 BEGIN

     SET @StartMonthYear = @StartMonthYear + 89

  END ELSE BEGIN

    SET @StartMonthYear = @StartMonthYear + 1

  END

END

SELECT * FROM @Dates

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PERCENT_POSITION_COVERAGE] TO [db_sp_exec]
    AS [dbo];

