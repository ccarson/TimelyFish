CREATE TABLE [dbo].[cft_SITE_PORK_BOARD_AUDIT] (
    [PorkBoardAuditID]    INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteID]              INT              NOT NULL,
    [PorkBoardAuditor]    VARCHAR (50)     NOT NULL,
    [PorkBoardAuditDate]  DATETIME         NOT NULL,
    [PorkBoardAuditPass]  BIT              CONSTRAINT [DF_cft_SITE_PQA_ASSESSMENT_PorkBoardAuditPass] DEFAULT (0) NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_SITE_PORK_BOARD_AUDIT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_PORK_BOARD_AUDIT] PRIMARY KEY CLUSTERED ([PorkBoardAuditID] ASC) WITH (FILLFACTOR = 90)
);

