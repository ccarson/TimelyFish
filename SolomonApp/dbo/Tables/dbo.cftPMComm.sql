CREATE TABLE [dbo].[cftPMComm] (
    [CommCatID]     CHAR (2)      NULL,
    [Comment]       CHAR (500)    NULL,
    [CommentDate]   SMALLDATETIME NULL,
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMID]          INT           NULL,
    [RoleTypeID]    CHAR (3)      NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPMComm0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

