CREATE TABLE [dbo].[cft_DAILY_PRICE] (
    [DailyPriceID]    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Date]            DATETIME     NOT NULL,
    [FeedMillID]      CHAR (10)    NOT NULL,
    [Approved]        BIT          NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_DAILY_PRICE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_DAILY_PRICE] PRIMARY KEY CLUSTERED ([DailyPriceID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_DAILY_PRICE_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_DAILY_PRICE_01]
    ON [dbo].[cft_DAILY_PRICE]([FeedMillID] ASC, [Date] ASC, [Approved] ASC, [DailyPriceID] ASC) WITH (FILLFACTOR = 90);


GO

CREATE TRIGGER [cftr_History_cft_DAILY_PRICE] ON [dbo].[cft_DAILY_PRICE]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_DAILY_PRICE
  (
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
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

    INSERT INTO dbo.cft_AR_DAILY_PRICE
    (
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_DAILY_PRICE
  (
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [DailyPriceID]
      ,[Date]
      ,[FeedMillID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Inserted  

  END


GO

-- ============================================================
-- UPDATE: Only retrieve rows within custom date range - nhonetschlager 2/4/14
-- ============================================================
CREATE TRIGGER [dbo].[cftr_cft_DAILY_PRICE_UPDATE_TICKETS] ON [dbo].[cft_DAILY_PRICE]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON


DECLARE @Dates TABLE
(
   id int not null identity(1,1),
   Date datetime not null
)

DECLARE @Date datetime,
        @i int,
        @imax int

IF EXISTS (SELECT 1 FROM Inserted) BEGIN
  INSERT @Dates SELECT Date FROM Inserted
END ELSE BEGIN
  INSERT @Dates SELECT Date FROM Deleted
END


SELECT @imax = Max(id) FROM @Dates
SELECT @i = 1

WHILE @i <= @imax BEGIN

SELECT @Date = Date FROM @Dates WHERE id = @i

UPDATE dbo.cft_PARTIAL_TICKET
SET DailyPriceDetailID = (
                             SELECT DPD.DailyPriceDetailID
                             FROM dbo.cft_DAILY_PRICE_DETAIL DPD 
                             INNER JOIN ( 
                                            SELECT TOP 1 DailyPriceID 
                                            FROM dbo.cft_DAILY_PRICE
                                            WHERE FeedMillID = FT.FeedMillID AND Date <= PT.DeliveryDate AND Approved = 1
                                            ORDER BY Date DESC
                                         )  DP ON DP.DailyPriceID = DPD.DailyPriceID
                             WHERE DPD.DeliveryMonth = month(PT.DeliveryDate) 
                             AND DPD.DeliveryYear = year(PT.DeliveryDate) 
                             AND DAY(PT.DeliveryDate) >= DAY(DPD.DeliveryDateFrom)		-- added 2/4/14 NJH
                             AND DAY(PT.DeliveryDate) <= DAY(DPD.DeliveryDateTo)		-- added 2/4/14	NJH
                          )
 FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
WHERE PT.DeliveryDate >= @Date

SET @i = @i + 1

END


