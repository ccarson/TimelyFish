CREATE TABLE [dbo].[cft_Eval] (
    [Eval_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]   CHAR (6)     NULL,
    [SvcMgrContactID] CHAR (6)     NULL,
    [EntryDate]       DATETIME     NOT NULL,
    [EntryUserID]     VARCHAR (30) NOT NULL,
    [FormID]          INT          NOT NULL,
    [EvalContactID]   CHAR (6)     NULL,
    [Comments]        TEXT         NULL,
    [EvalDate]        DATETIME     NULL,
    [EntryUserID2]    VARCHAR (30) NULL,
    CONSTRAINT [pk_Eval] PRIMARY KEY CLUSTERED ([Eval_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [fk_cft_Eval_FormId] FOREIGN KEY ([FormID]) REFERENCES [dbo].[cft_Form] ([FormID])
);


GO
CREATE NONCLUSTERED INDEX [ix_CFT_EVAL_formid_evaldate_include]
    ON [dbo].[cft_Eval]([FormID] ASC, [EvalDate] ASC)
    INCLUDE([Eval_id], [SiteContactID]) WITH (FILLFACTOR = 90);

