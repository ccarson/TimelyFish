CREATE TABLE [dbo].[cft_FULL_TICKET_ASSIGNMENT] (
    [FullTicketAssignmentID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TicketID]               INT            NOT NULL,
    [CornProducerID]         VARCHAR (15)   NOT NULL,
    [Assignment]             DECIMAL (7, 4) NOT NULL,
    [GroupName]              VARCHAR (1000) NOT NULL,
    [CreatedDateTime]        DATETIME       CONSTRAINT [DF_cft_FULL_TICKET_ASSIGNMENT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]        DATETIME       NULL,
    [UpdatedBy]              VARCHAR (50)   NULL,
    CONSTRAINT [PK_cft_FULL_TICKET_ASSIGNMENT] PRIMARY KEY CLUSTERED ([FullTicketAssignmentID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_FULL_TICKET_ASSIGNMENT_cft_CORN_PRODUCER] FOREIGN KEY ([CornProducerID]) REFERENCES [dbo].[cft_CORN_PRODUCER] ([CornProducerID]),
    CONSTRAINT [FK_cft_FULL_TICKET_ASSIGNMENT_cft_CORN_TICKET] FOREIGN KEY ([TicketID]) REFERENCES [dbo].[cft_CORN_TICKET] ([TicketID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_FULL_TICKET_ASSIGNMENT_CornProducerID_TicketID]
    ON [dbo].[cft_FULL_TICKET_ASSIGNMENT]([CornProducerID] ASC, [TicketID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ix_cft_FULL_TICKET_ASSIGNMENT_TicketID]
    ON [dbo].[cft_FULL_TICKET_ASSIGNMENT]([TicketID] ASC);


GO


CREATE TRIGGER [cftr_History_cft_FULL_TICKET_ASSIGNMENT] ON [dbo].[cft_FULL_TICKET_ASSIGNMENT]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_FULL_TICKET_ASSIGNMENT
  (
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]
  )
  SELECT
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
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

    INSERT INTO dbo.cft_AR_FULL_TICKET_ASSIGNMENT
    (
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_FULL_TICKET_ASSIGNMENT
  (
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [FullTicketAssignmentID]
      ,[TicketID]
      ,[CornProducerID]
      ,[Assignment]
      ,[GroupName]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Inserted  

  END


