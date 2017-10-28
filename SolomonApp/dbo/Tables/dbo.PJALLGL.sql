CREATE TABLE [dbo].[PJALLGL] (
    [alloc_batch]       CHAR (10)     NOT NULL,
    [amount]            FLOAT (53)    NOT NULL,
    [cpnyId]            CHAR (10)     NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME NOT NULL,
    [Crtd_Prog]         CHAR (8)      NOT NULL,
    [Crtd_User]         CHAR (10)     NOT NULL,
    [data1]             CHAR (10)     NOT NULL,
    [data2]             CHAR (30)     NOT NULL,
    [gl_acct]           CHAR (10)     NOT NULL,
    [gl_subacct]        CHAR (24)     NOT NULL,
    [glsort_key]        INT           NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME NOT NULL,
    [LUpd_Prog]         CHAR (8)      NOT NULL,
    [LUpd_User]         CHAR (10)     NOT NULL,
    [source_project]    CHAR (16)     NOT NULL,
    [source_pjt_entity] CHAR (32)     NOT NULL,
    [project]           CHAR (16)     NOT NULL,
    [pjt_entity]        CHAR (32)     NOT NULL,
    [units]             FLOAT (53)    NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [pjallgl0] PRIMARY KEY NONCLUSTERED ([alloc_batch] ASC, [glsort_key] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE CLUSTERED INDEX [pjallgl1]
    ON [dbo].[PJALLGL]([alloc_batch] ASC, [source_project] ASC, [source_pjt_entity] ASC, [project] ASC, [pjt_entity] ASC, [cpnyId] ASC, [gl_acct] ASC, [gl_subacct] ASC) WITH (FILLFACTOR = 90);

