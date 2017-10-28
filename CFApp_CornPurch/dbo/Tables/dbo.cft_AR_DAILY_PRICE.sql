CREATE TABLE [dbo].[cft_AR_DAILY_PRICE] (
    [ARDailyPriceID]  INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DailyPriceID]    INT            NULL,
    [Date]            DATETIME       NULL,
    [Approved]        BIT            NULL,
    [CreatedDateTime] DATETIME       NULL,
    [CreatedBy]       VARCHAR (50)   NULL,
    [UpdatedDateTime] DATETIME       NULL,
    [UpdatedBy]       VARCHAR (50)   NULL,
    [RowChangeTypeID] TINYINT        NOT NULL,
    [UserName]        NVARCHAR (128) CONSTRAINT [DF_cft_AR_DAILY_PRICE_UserName] DEFAULT (suser_sname()) NOT NULL,
    [HostName]        NVARCHAR (128) CONSTRAINT [DF_cft_AR_DAILY_PRICE_HostName] DEFAULT (host_name()) NOT NULL,
    [AppName]         NVARCHAR (128) CONSTRAINT [DF_cft_AR_DAILY_PRICE_AppName] DEFAULT (app_name()) NOT NULL,
    [TimeStamp]       DATETIME       CONSTRAINT [DF_cft_AR_DAILY_PRICE_TimeStamp] DEFAULT (getdate()) NOT NULL,
    [FeedMillID]      CHAR (10)      NULL,
    CONSTRAINT [PK_cft_AR_DAILY_PRICE] PRIMARY KEY CLUSTERED ([ARDailyPriceID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_AR_DAILY_PRICE_cft_ROW_CHANGE_TYPE] FOREIGN KEY ([RowChangeTypeID]) REFERENCES [dbo].[cft_ROW_CHANGE_TYPE] ([RowChangeTypeID])
);

