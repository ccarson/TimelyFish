CREATE TABLE [dbo].[cft_DAILY_PRICE_DETAIL_COMPETITOR] (
    [DailyPriceDetailCompetitorID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DailyPriceDetailID]           INT             NOT NULL,
    [CompetitorID]                 SMALLINT        NOT NULL,
    [Price]                        DECIMAL (20, 4) NULL,
    [CreatedDateTime]              DATETIME        CONSTRAINT [DF_cft_DAILY_PRICE_DETAIL_COMPETITOR_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                    VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]              DATETIME        NULL,
    [UpdatedBy]                    VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_DAILY_PRICE_DETAIL_COMPETITOR] PRIMARY KEY CLUSTERED ([DailyPriceDetailCompetitorID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_DAILY_PRICE_DETAIL_COMPETITOR_cft_COMPETITOR] FOREIGN KEY ([CompetitorID]) REFERENCES [dbo].[cft_COMPETITOR] ([CompetitorID]),
    CONSTRAINT [FK_cft_DAILY_PRICE_DETAIL_COMPETITOR_cft_DAILY_PRICE_DETAIL] FOREIGN KEY ([DailyPriceDetailID]) REFERENCES [dbo].[cft_DAILY_PRICE_DETAIL] ([DailyPriceDetailID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_DAILY_PRICE_DETAIL_COMPETITOR_01]
    ON [dbo].[cft_DAILY_PRICE_DETAIL_COMPETITOR]([DailyPriceDetailID] ASC, [CompetitorID] ASC, [Price] ASC) WITH (FILLFACTOR = 90);


GO


CREATE TRIGGER [cftr_History_cft_DAILY_PRICE_DETAIL_COMPETITOR] ON [dbo].[cft_DAILY_PRICE_DETAIL_COMPETITOR]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL_COMPETITOR
  (
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
  )
  SELECT
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
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

    INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL_COMPETITOR
    (
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
    )
    SELECT
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,@RowChangeTypeID
    FROM Inserted  

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
    INSERT INTO dbo.cft_AR_DAILY_PRICE_DETAIL_COMPETITOR
    (
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,[RowChangeTypeID]
    )
    SELECT
        [DailyPriceDetailCompetitorID]
       ,[DailyPriceDetailID]
       ,[CompetitorID]
       ,[Price]
       ,[CreatedDateTime]
       ,[CreatedBy]
       ,[UpdatedDateTime]
       ,[UpdatedBy]
       ,@RowChangeTypeID
    FROM Inserted  

  END


