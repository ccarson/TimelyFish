CREATE TABLE [dbo].[cft_COMMISSION] (
    [PartialTicketID]      INT             NOT NULL,
    [MarketerID]           TINYINT         NOT NULL,
    [Percent]              DECIMAL (18, 4) NOT NULL,
    [Rate]                 DECIMAL (20, 6) NULL,
    [CommissionRateTypeID] INT             NULL,
    [Approved]             BIT             CONSTRAINT [DF_cft_COMMISSION_DETAIL_Approved] DEFAULT (0) NOT NULL,
    [CreatedDateTime]      DATETIME        CONSTRAINT [DF_cft_COMMISSION_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]      DATETIME        NULL,
    [UpdatedBy]            VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_COMMISSION_DETAIL] PRIMARY KEY CLUSTERED ([PartialTicketID] ASC, [MarketerID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_COMMISSION_DETAIL_cft_COMMISSION_RATE_TYPE] FOREIGN KEY ([CommissionRateTypeID]) REFERENCES [dbo].[cft_COMMISSION_RATE_TYPE] ([CommissionRateTypeID]),
    CONSTRAINT [FK_cft_COMMISSION_DETAIL_cft_MARKETER] FOREIGN KEY ([MarketerID]) REFERENCES [dbo].[cft_MARKETER] ([MarketerID]),
    CONSTRAINT [FK_cft_COMMISSION_DETAIL_cft_PARTIAL_TICKET] FOREIGN KEY ([PartialTicketID]) REFERENCES [dbo].[cft_PARTIAL_TICKET] ([PartialTicketID]) ON DELETE CASCADE
);


GO

CREATE TRIGGER dbo.cftr_History_cft_COMMISSION ON dbo.cft_COMMISSION
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_COMMISSION
  (
     [PartialTicketID]
    ,[Percent]
    ,[Rate]
    ,[CommissionRateTypeID]
    ,[Approved]
    ,[CreatedDateTime]
    ,[CreatedBy]
    ,[UpdatedDateTime]
    ,[UpdatedBy]
    ,[RowChangeTypeID]
  )
  SELECT
     [PartialTicketID]
    ,[Percent]
    ,[Rate]
    ,[CommissionRateTypeID]
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

    INSERT INTO dbo.cft_AR_COMMISSION
    (
       [PartialTicketID]
      ,[Percent]
      ,[Rate]
      ,[CommissionRateTypeID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [PartialTicketID]
      ,[Percent]
      ,[Rate]
      ,[CommissionRateTypeID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_COMMISSION
  (
       [PartialTicketID]
      ,[Percent]
      ,[Rate]
      ,[CommissionRateTypeID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [PartialTicketID]
      ,[Percent]
      ,[Rate]
      ,[CommissionRateTypeID]
      ,[Approved]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Inserted  

  END

