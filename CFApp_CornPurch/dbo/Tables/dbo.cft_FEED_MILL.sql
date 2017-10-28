CREATE TABLE [dbo].[cft_FEED_MILL] (
    [FeedMillID]               CHAR (10)       NOT NULL,
    [Name]                     VARCHAR (50)    NOT NULL,
    [Address1]                 VARCHAR (30)    NULL,
    [Address2]                 VARCHAR (30)    NULL,
    [City]                     VARCHAR (30)    NULL,
    [State]                    VARCHAR (2)     NULL,
    [Zip]                      VARCHAR (10)    NULL,
    [County]                   VARCHAR (30)    NULL,
    [SentToDryer]              BIT             NOT NULL,
    [DryerCapacity]            DECIMAL (18, 4) NOT NULL,
    [UnloadingTime]            DECIMAL (18, 4) NOT NULL,
    [ReceivingHours]           VARCHAR (5000)  NOT NULL,
    [GrainDealerLicenseNumber] VARCHAR (50)    NULL,
    [Comments]                 VARCHAR (5000)  NULL,
    [WEMServer]                VARCHAR (200)   NULL,
    [CreatedDateTime]          DATETIME        CONSTRAINT [DF_cft_FEED_MILL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]          DATETIME        NULL,
    [UpdatedBy]                VARCHAR (50)    NULL,
    [Company]                  VARCHAR (100)   NULL,
    CONSTRAINT [PK_cft_FEED_MILL] PRIMARY KEY CLUSTERED ([FeedMillID] ASC) WITH (FILLFACTOR = 90)
);

