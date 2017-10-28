CREATE TABLE [dbo].[cft_REPORT_MORTALITY_DETAIL_FIN] (
    [MortalityDetailFinID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DeadsWeeklyLimitPercent]     DECIMAL (10, 2)  NULL,
    [DeadsFiscalYearLimitPercent] DECIMAL (10, 2)  NULL,
    [CreatedDateTime]             DATETIME         CONSTRAINT [DF_cft_REPORT_MORTALITY_DETAIL_FIN_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                   VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]             DATETIME         NULL,
    [UpdatedBy]                   VARCHAR (50)     NULL,
    [msrepl_tran_version]         UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_REPORT_MORTALITY_DETAIL_FIN] PRIMARY KEY CLUSTERED ([MortalityDetailFinID] ASC) WITH (FILLFACTOR = 90)
);

