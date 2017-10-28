CREATE TABLE [dbo].[cft_TARGET_LINE] (
    [TargetLineID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TargetLineTypeID]    INT              NOT NULL,
    [TargetLineValue]     DECIMAL (10, 3)  NOT NULL,
    [PICWeek]             SMALLINT         NULL,
    [PICYear]             SMALLINT         NULL,
    [PigFlowID]           INT              NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_TARGET_LINE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_TARGET_LINE] PRIMARY KEY CLUSTERED ([TargetLineID] ASC) WITH (FILLFACTOR = 90)
);

