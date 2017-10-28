CREATE TABLE [dbo].[smBatch] (
    [Batnbr]        CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Created]       SMALLDATETIME NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CtrlAmt]       FLOAT (53)    NOT NULL,
    [DateEnt]       SMALLDATETIME NOT NULL,
    [DateRel]       SMALLDATETIME NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [EditScrNbr]    CHAR (10)     NOT NULL,
    [Handling]      CHAR (1)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (1)      NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smBatch0] PRIMARY KEY CLUSTERED ([Batnbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smBatch1]
    ON [dbo].[smBatch]([EditScrNbr] ASC, [Batnbr] ASC) WITH (FILLFACTOR = 90);

