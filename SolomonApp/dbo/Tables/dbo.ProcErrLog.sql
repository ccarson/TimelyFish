CREATE TABLE [dbo].[ProcErrLog] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [ErrDesc]       CHAR (1020)   NOT NULL,
    [ErrNo]         INT           NOT NULL,
    [ExecString]    CHAR (510)    NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [RecordID]      INT           NOT NULL,
    [SortKey]       INT           NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [ProcErrLog0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ProcErrLog1]
    ON [dbo].[ProcErrLog]([SortKey] ASC) WITH (FILLFACTOR = 90);

