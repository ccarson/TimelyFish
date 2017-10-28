CREATE TABLE [dbo].[cft_ELEVATOR_SALE_BASIS] (
    [ElevatorSaleBasisID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Date]                DATETIME        NOT NULL,
    [FeedMillID]          CHAR (10)       NOT NULL,
    [Amount]              DECIMAL (10, 4) NOT NULL,
    [CreatedDateTime]     DATETIME        CONSTRAINT [DF_cft_ELEVATOR_SALE_BASIS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]     DATETIME        NULL,
    [UpdatedBy]           VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_ELEVATOR_SALE_BASIS] PRIMARY KEY CLUSTERED ([ElevatorSaleBasisID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_ELEVATOR_SALE_BASIS_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

