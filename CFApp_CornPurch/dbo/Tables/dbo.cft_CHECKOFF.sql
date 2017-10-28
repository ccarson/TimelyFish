CREATE TABLE [dbo].[cft_CHECKOFF] (
    [CheckoffID]      INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]      CHAR (10)       NOT NULL,
    [CheckoffTypeID]  INT             NOT NULL,
    [Active]          BIT             NOT NULL,
    [Rate]            DECIMAL (20, 6) NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_CHECKOFF_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_CHECKOFF] PRIMARY KEY CLUSTERED ([CheckoffID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CHECKOFF_cft_CHECKOFF_TYPE] FOREIGN KEY ([CheckoffTypeID]) REFERENCES [dbo].[cft_CHECKOFF_TYPE] ([CheckoffTypeID]),
    CONSTRAINT [FK_cft_CHECKOFF_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

