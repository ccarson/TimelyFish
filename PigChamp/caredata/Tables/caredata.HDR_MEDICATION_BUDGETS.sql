CREATE TABLE [caredata].[HDR_MEDICATION_BUDGETS] (
    [budget_id]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [budget_name]      VARCHAR (20) NOT NULL,
    [feed_budget_id]   INT          NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_HDR_MEDICATION_BUDGETS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_HDR_MEDICATION_BUDGETS_system] DEFAULT ((0)) NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_MEDICATION_BUDGETS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_MEDICATION_BUDGETS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_MEDICATION_BUDGETS] PRIMARY KEY NONCLUSTERED ([budget_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HDR_MEDICATION_BUDGETS_HDR_FEED_BUDGETS_0] FOREIGN KEY ([feed_budget_id]) REFERENCES [caredata].[HDR_FEED_BUDGETS] ([budget_id]) ON DELETE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_MEDICATION_BUDGETS_0]
    ON [caredata].[HDR_MEDICATION_BUDGETS]([budget_name] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

