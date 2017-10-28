CREATE TABLE [dbo].[PermitRenewal] (
    [PermitID]         INT           NOT NULL,
    [NotificationDate] SMALLDATETIME NULL,
    [SubmittedDate]    SMALLDATETIME NOT NULL,
    [RenewalIssueDate] SMALLDATETIME NULL,
    CONSTRAINT [PK_PermitDateDetail] PRIMARY KEY CLUSTERED ([PermitID] ASC, [SubmittedDate] ASC) WITH (FILLFACTOR = 90)
);

