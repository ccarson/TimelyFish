CREATE TABLE [dbo].[cftSiteEval] (
    [Eval_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]   CHAR (6)     NULL,
    [SvcMgrContactID] CHAR (6)     NULL,
    [EntryDate]       DATETIME     NOT NULL,
    [EntryUserID]     VARCHAR (30) NOT NULL,
    CONSTRAINT [pk_SiteEval] PRIMARY KEY CLUSTERED ([Eval_id] ASC) WITH (FILLFACTOR = 80)
);

