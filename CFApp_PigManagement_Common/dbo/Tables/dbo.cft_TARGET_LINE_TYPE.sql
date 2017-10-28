CREATE TABLE [dbo].[cft_TARGET_LINE_TYPE] (
    [TargetLineTypeID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TargetLineMasterTypeID]    INT              NOT NULL,
    [TargetLineTypeDescription] VARCHAR (50)     NOT NULL,
    [CreatedDateTime]           DATETIME         CONSTRAINT [DF_cft_TARGET_LINE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                 VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]           DATETIME         NULL,
    [UpdatedBy]                 VARCHAR (50)     NULL,
    [msrepl_tran_version]       UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_TARGET_LINE_TYPE] PRIMARY KEY CLUSTERED ([TargetLineTypeID] ASC) WITH (FILLFACTOR = 90)
);

