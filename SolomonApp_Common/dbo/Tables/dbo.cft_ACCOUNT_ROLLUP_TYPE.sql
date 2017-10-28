CREATE TABLE [dbo].[cft_ACCOUNT_ROLLUP_TYPE] (
    [AccountRollupTypeID]      INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AccountRollupDescription] VARCHAR (100) NULL,
    [ReportOrder]              INT           NULL,
    [CreatedDateTime]          DATETIME      CONSTRAINT [DF_cft_ACCOUNT_ROLLUP_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)  NOT NULL,
    [UpdatedDateTime]          DATETIME      NULL,
    [UpdatedBy]                VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_ACCOUNT_ROLLUP_TYPE] PRIMARY KEY CLUSTERED ([AccountRollupTypeID] ASC) WITH (FILLFACTOR = 90)
);

