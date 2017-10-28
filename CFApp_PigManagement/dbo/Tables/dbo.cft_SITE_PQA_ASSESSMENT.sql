CREATE TABLE [dbo].[cft_SITE_PQA_ASSESSMENT] (
    [PqaAssessmentID]       INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteID]                INT              NOT NULL,
    [AdvisorID]             INT              NOT NULL,
    [OriginalIssueDateTime] DATETIME         NOT NULL,
    [ExpirationDateTime]    DATETIME         NOT NULL,
    [RenewalLeadDateTime]   DATETIME         NOT NULL,
    [Active]                BIT              CONSTRAINT [DF_cft_SITE_PQA_ASSESSMENT_Active] DEFAULT (0) NULL,
    [CreatedDateTime]       DATETIME         CONSTRAINT [DF_cft_SITE_PQA_ASSESSMENT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]       DATETIME         NULL,
    [UpdatedBy]             VARCHAR (50)     NULL,
    [msrepl_tran_version]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_PQA_ASSESSMENT] PRIMARY KEY CLUSTERED ([PqaAssessmentID] ASC) WITH (FILLFACTOR = 90)
);

