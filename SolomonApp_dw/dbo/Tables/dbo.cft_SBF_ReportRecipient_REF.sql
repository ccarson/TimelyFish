CREATE TABLE [dbo].[cft_SBF_ReportRecipient_REF] (
    [ReportRecipientID] INT           IDENTITY (1, 1) NOT NULL,
    [SBFReportName]     VARCHAR (20)  NULL,
    [RecipientName]     VARCHAR (50)  NULL,
    [RecipientEmail]    VARCHAR (100) NULL,
    CONSTRAINT [PK_cft_SBF_ReportRecipient_REF] PRIMARY KEY CLUSTERED ([ReportRecipientID] ASC) WITH (FILLFACTOR = 90)
);

