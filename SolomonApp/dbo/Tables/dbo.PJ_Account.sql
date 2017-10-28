CREATE TABLE [dbo].[PJ_Account] (
    [acct]          CHAR (16)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [employ_sw]     CHAR (1)      NOT NULL,
    [ga_id01]       CHAR (1)      NOT NULL,
    [ga_id02]       CHAR (1)      NOT NULL,
    [ga_id03]       CHAR (1)      NOT NULL,
    [gl_acct]       CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [units_sw]      CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pj_account0] PRIMARY KEY CLUSTERED ([gl_acct] ASC) WITH (FILLFACTOR = 90)
);

