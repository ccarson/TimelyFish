CREATE TABLE [dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES] (
    [CreatedDateTime]    DATETIME        NOT NULL,
    [CreatedBy]          VARCHAR (50)    NOT NULL,
    [FeedMillID]         CHAR (10)       NOT NULL,
    [MaxDryBushels]      DECIMAL (18, 4) NULL,
    [MaxForeignMaterial] DECIMAL (18, 4) NULL,
    [MinMoistureContent] DECIMAL (18, 4) NULL,
    [MaxMoistureContent] DECIMAL (18, 4) NULL,
    [MaxNetWeight]       DECIMAL (18, 4) NULL,
    [MinTestWeight]      DECIMAL (18, 4) NULL,
    [MaxTestWeight]      DECIMAL (18, 4) NULL,
    [RangeValueID]       INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [UpdatedDateTime]    DATETIME        NULL,
    [UpdatedBy]          VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_CORN_PURCHASING_TICKET_RANGE_VALUES] PRIMARY KEY CLUSTERED ([RangeValueID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CORN_PURCHASING_TICKET_RANGE_VALUES_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES] TO [db_sp_exec]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES] TO [db_sp_exec]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES] TO [db_sp_exec]
    AS [dbo];

