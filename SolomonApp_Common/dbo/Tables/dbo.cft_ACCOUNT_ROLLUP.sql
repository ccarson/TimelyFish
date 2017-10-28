CREATE TABLE [dbo].[cft_ACCOUNT_ROLLUP] (
    [AccountRollupID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AccountRollupTypeID] INT          NOT NULL,
    [Account]             VARCHAR (10) NULL,
    [Division]            CHAR (2)     NOT NULL,
    [Department]          CHAR (2)     NOT NULL,
    [CreatedDateTime]     DATETIME     CONSTRAINT [DF_cft_ACCOUNT_ROLLUP_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50) NOT NULL,
    [UpdatedDateTime]     DATETIME     NULL,
    [UpdatedBy]           VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ACCOUNT_ROLLUP] PRIMARY KEY CLUSTERED ([AccountRollupID] ASC) WITH (FILLFACTOR = 90)
);

