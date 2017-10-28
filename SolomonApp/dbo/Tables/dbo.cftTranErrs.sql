CREATE TABLE [dbo].[cftTranErrs] (
    [BatNbr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [ErrDesc]       CHAR (150)    NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Module]        CHAR (2)      NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftTranErrs0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [Module] ASC, [LineNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90)
);

