CREATE TABLE [dbo].[cft_FINANCIAL_MONTH] (
    [FinancialMonthID] TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]             CHAR (2)     NOT NULL,
    [CreatedDateTime]  DATETIME     CONSTRAINT [DF_cft_FINANCIAL_MONTH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]        VARCHAR (50) NOT NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_FINANCIAL_MONTH] PRIMARY KEY CLUSTERED ([FinancialMonthID] ASC) WITH (FILLFACTOR = 90)
);

