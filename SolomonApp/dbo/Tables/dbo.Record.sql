CREATE TABLE [dbo].[Record] (
    [Active]          CHAR (1)      NOT NULL,
    [DATFileName]     CHAR (8)      NOT NULL,
    [Module]          CHAR (2)      NOT NULL,
    [OldRecordName]   CHAR (20)     NOT NULL,
    [RecordDescripti] CHAR (25)     NOT NULL,
    [RecordName]      CHAR (20)     NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [Record0] PRIMARY KEY CLUSTERED ([RecordName] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Record1]
    ON [dbo].[Record]([Module] ASC, [RecordName] ASC) WITH (FILLFACTOR = 90);

