CREATE TABLE [dbo].[cft_PIG_SYSTEM] (
    [PigSystemID]         INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                VARCHAR (50)     NOT NULL,
    [Description]         VARCHAR (100)    NOT NULL,
    [Active]              BIT              CONSTRAINT [DF_cft_PIG_SYSTEM_Active] DEFAULT (1) NOT NULL,
    [HasFlow]             BIT              CONSTRAINT [DF_cft_PIG_SYSTEM_HasFlow] DEFAULT (0) NOT NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_PIG_SYSTEM_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_PIG_SYSTEM] PRIMARY KEY CLUSTERED ([PigSystemID] ASC) WITH (FILLFACTOR = 90)
);

