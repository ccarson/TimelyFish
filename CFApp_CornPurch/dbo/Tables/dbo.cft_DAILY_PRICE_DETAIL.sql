CREATE TABLE [dbo].[cft_DAILY_PRICE_DETAIL] (
    [DailyPriceDetailID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DailyPriceID]       INT             NOT NULL,
    [DeliveryMonth]      TINYINT         NOT NULL,
    [DeliveryYear]       SMALLINT        NOT NULL,
    [OptionMonth]        TINYINT         NOT NULL,
    [NonClassicalTrade]  BIT             NOT NULL,
    [CBOTCornClose]      DECIMAL (20, 4) NULL,
    [CBOTChange]         DECIMAL (20, 4) NULL,
    [CompetitorBasis]    DECIMAL (20, 4) NULL,
    [CompetitorFreight]  DECIMAL (20, 4) NULL,
    [Adj]                DECIMAL (20, 4) NULL,
    [NoBid]              BIT             NOT NULL,
    [DeliveryDate]       AS              (case when (len(datename(month,convert(datetime,(ltrim(str([DeliveryMonth])) + '/01/2008'),101))) <= 4) then (datename(month,convert(datetime,(ltrim(str([DeliveryMonth])) + '/01/2008'),101))) else (left(datename(month,convert(datetime,(ltrim(str([DeliveryMonth])) + '/01/2008'),101)),3)) end + ' ''' + right(ltrim(str([DeliveryYear])),2)),
    [CreatedDateTime]    DATETIME        CONSTRAINT [DF_cft_DAILY_PRICE_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]          VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]    DATETIME        NULL,
    [UpdatedBy]          VARCHAR (50)    NULL,
    [Price]              AS              (case when ([NoBid] <> 1) then (isnull([CBOTCornClose],0) + isnull([CompetitorBasis],0) + isnull([CompetitorFreight],0) + isnull([Adj],0)) end),
    [DeliveryDateFrom]   DATE            NULL,
    [DeliveryDateTo]     DATE            NULL,
    CONSTRAINT [PK_cft_DAILY_PRICE_DETAIL] PRIMARY KEY CLUSTERED ([DailyPriceDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_DAILY_PRICE_DETAIL_cft_DAILY_PRICE] FOREIGN KEY ([DailyPriceID]) REFERENCES [dbo].[cft_DAILY_PRICE] ([DailyPriceID]),
    CONSTRAINT [FK_cft_DAILY_PRICE_DETAIL_cft_FINANCIAL_MONTH] FOREIGN KEY ([OptionMonth]) REFERENCES [dbo].[cft_FINANCIAL_MONTH] ([FinancialMonthID])
);


GO
CREATE NONCLUSTERED INDEX [ix_cft_DAILY_PRICE_DETAIL_02]
    ON [dbo].[cft_DAILY_PRICE_DETAIL]([DailyPriceID] ASC)
    INCLUDE([CBOTCornClose], [CompetitorBasis], [CompetitorFreight], [Adj], [NoBid]);


GO
CREATE NONCLUSTERED INDEX [IX_cft_DAILY_PRICE_DETAIL_01]
    ON [dbo].[cft_DAILY_PRICE_DETAIL]([DeliveryYear] ASC, [DeliveryMonth] ASC, [DailyPriceID] ASC) WITH (FILLFACTOR = 90);


GO

/* 
==================================================================== 
Change Log: 
Date        Who           	   Change 
----------- ------------------ ------------------------------------- 
2013-10-09  Nick Honetschlager Altered to use new delivery columns.                                                 
====================================================================
*/

CREATE TRIGGER [dbo].[cftr_History_cft_DAILY_PRICE_DETAIL] ON [dbo].[cft_DAILY_PRICE_DETAIL]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL
  (
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDate]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
  )
  SELECT
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDate]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,@RowChangeTypeID
  FROM Inserted  

END 
  ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM Inserted)
  BEGIN

    SET @RowChangeTypeID = 3	--Delete

    INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL
    (
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDate]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
    )
    SELECT
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDate]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,@RowChangeTypeID
    FROM Inserted  

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
    INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL
    (
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDate]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
    )
    SELECT
        [DailyPriceDetailID]
       ,[DailyPriceID]
       ,[DeliveryMonth]
       ,[DeliveryYear]
       ,[DeliveryDateFrom]		--added 10/9/13 NJH
       ,[DeliveryDateTo]		--added 10/9/13 NJH
       ,[DeliveryDateTo]
       ,[OptionMonth]
       ,[NonClassicalTrade]
       ,[CBOTCornClose]
       ,[CBOTChange]
       ,[CompetitorBasis]
       ,[CompetitorFreight]
       ,[Adj]
       ,[NoBid]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,@RowChangeTypeID
    FROM Inserted  

  END


