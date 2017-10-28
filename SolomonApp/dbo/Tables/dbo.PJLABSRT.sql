CREATE TABLE [dbo].[PJLABSRT] (
    [amount]        FLOAT (53)    NOT NULL,
    [cpnyId]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [docnbr]        CHAR (10)     NOT NULL,
    [gl_acct]       CHAR (10)     NOT NULL,
    [gl_subacct]    CHAR (24)     NOT NULL,
    [hours]         FLOAT (53)    NOT NULL,
    [hrs_type]      CHAR (4)      NOT NULL,
    [labsrt_key]    INT           NOT NULL,
    [linenbr]       SMALLINT      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [status_2]      CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjlabsrt0] PRIMARY KEY CLUSTERED ([labsrt_key] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjlabsrt1]
    ON [dbo].[PJLABSRT]([cpnyId] ASC, [gl_acct] ASC, [gl_subacct] ASC) WITH (FILLFACTOR = 90);

