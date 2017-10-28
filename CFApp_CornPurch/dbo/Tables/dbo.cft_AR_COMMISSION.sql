CREATE TABLE [dbo].[cft_AR_COMMISSION] (
    [ARCommissionID]       INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PartialTicketID]      INT             NULL,
    [MarketerID]           TINYINT         NULL,
    [Percent]              DECIMAL (18, 4) NULL,
    [Rate]                 DECIMAL (20, 6) NULL,
    [CommissionRateTypeID] INT             NULL,
    [Approved]             BIT             NULL,
    [CreatedDateTime]      DATETIME        NULL,
    [CreatedBy]            VARCHAR (50)    NULL,
    [UpdatedDateTime]      DATETIME        NULL,
    [UpdatedBy]            VARCHAR (50)    NULL,
    [RowChangeTypeID]      TINYINT         NOT NULL,
    [UserName]             NVARCHAR (128)  CONSTRAINT [DF_cft_AR_COMMISSION_DETAIL_UserName] DEFAULT (suser_sname()) NOT NULL,
    [HostName]             NVARCHAR (128)  CONSTRAINT [DF_cft_AR_COMMISSION_DETAIL_HostName] DEFAULT (host_name()) NOT NULL,
    [AppName]              NVARCHAR (128)  CONSTRAINT [DF_cft_AR_COMMISSION_DETAIL_AppName] DEFAULT (app_name()) NOT NULL,
    [TimeStamp]            DATETIME        CONSTRAINT [DF_cft_AR_COMMISSION_DETAIL_TimeStamp] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cft_AR_COMMISSION_DETAIL] PRIMARY KEY CLUSTERED ([ARCommissionID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_AR_COMMISSION_DETAIL_cft_ROW_CHANGE_TYPE] FOREIGN KEY ([RowChangeTypeID]) REFERENCES [dbo].[cft_ROW_CHANGE_TYPE] ([RowChangeTypeID])
);

