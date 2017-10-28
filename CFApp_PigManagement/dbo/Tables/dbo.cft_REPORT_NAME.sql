CREATE TABLE [dbo].[cft_REPORT_NAME] (
    [ReportID]            INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ReportName]          VARCHAR (100)    NOT NULL,
    [ReportDescription]   VARCHAR (255)    NOT NULL,
    [Active]              BIT              CONSTRAINT [DF_cft_REPORT_NAME_Active] DEFAULT (1) NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_REPORT_NAME_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_REPORT_NAME] PRIMARY KEY CLUSTERED ([ReportID] ASC) WITH (FILLFACTOR = 90)
);

