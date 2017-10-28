CREATE TABLE [dbo].[cft_Eval2] (
    [Eval_id]         INT          IDENTITY (1, 1) NOT NULL,
    [SiteContactID]   CHAR (6)     NULL,
    [SvcMgrContactID] CHAR (6)     NULL,
    [EntryDate]       DATETIME     NOT NULL,
    [EntryUserID]     VARCHAR (30) NOT NULL,
    [FormID]          INT          NOT NULL,
    [EvalContactID]   CHAR (6)     NULL,
    [Comments]        TEXT         NULL,
    [EvalDate]        DATETIME     NULL,
    [EntryUserID2]    VARCHAR (30) NULL
);

