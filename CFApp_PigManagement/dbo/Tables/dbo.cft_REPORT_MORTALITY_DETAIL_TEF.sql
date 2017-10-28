CREATE TABLE [dbo].[cft_REPORT_MORTALITY_DETAIL_TEF] (
    [MortalityDetailTefID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DeadsWeeklyLimitPercent]     DECIMAL (10, 2)  NULL,
    [DeadsFiscalYearLimitPercent] DECIMAL (10, 2)  NULL,
    [CreatedDateTime]             DATETIME         CONSTRAINT [DF_cft_REPORT_MORTALITY_DETAIL_TEF_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                   VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]             DATETIME         NULL,
    [UpdatedBy]                   VARCHAR (50)     NULL,
    [msrepl_tran_version]         UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_REPORT_MORTALITY_DETAIL_TEF] PRIMARY KEY CLUSTERED ([MortalityDetailTefID] ASC) WITH (FILLFACTOR = 90)
);

