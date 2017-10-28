CREATE TABLE [dbo].[cft_AR_DAILY_PRICE_DETAIL_COMPETITOR] (
    [ARDailyPriceDetailCompetitorID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DailyPriceDetailCompetitorID]   INT             NULL,
    [DailyPriceDetailID]             INT             NULL,
    [CompetitorID]                   SMALLINT        NULL,
    [Price]                          DECIMAL (20, 4) NULL,
    [CreatedDateTime]                DATETIME        NULL,
    [CreatedBy]                      VARCHAR (50)    NULL,
    [UpdatedDateTime]                DATETIME        NULL,
    [UpdatedBy]                      VARCHAR (50)    NULL,
    [RowChangeTypeID]                TINYINT         NOT NULL,
    [UserName]                       NVARCHAR (128)  CONSTRAINT [DF_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR_UserName] DEFAULT (suser_sname()) NOT NULL,
    [HostName]                       NVARCHAR (128)  CONSTRAINT [DF_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR_HostName] DEFAULT (host_name()) NOT NULL,
    [AppName]                        NVARCHAR (128)  CONSTRAINT [DF_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR_AppName] DEFAULT (app_name()) NOT NULL,
    [TimeStamp]                      DATETIME        CONSTRAINT [DF_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR_TimeStamp] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR] PRIMARY KEY CLUSTERED ([ARDailyPriceDetailCompetitorID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_AR_DAILY_PRICE_DETAIL_COMPETITOR_cft_ROW_CHANGE_TYPE] FOREIGN KEY ([RowChangeTypeID]) REFERENCES [dbo].[cft_ROW_CHANGE_TYPE] ([RowChangeTypeID])
);

