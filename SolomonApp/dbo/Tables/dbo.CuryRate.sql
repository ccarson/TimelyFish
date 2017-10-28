CREATE TABLE [dbo].[CuryRate] (
    [AutoCalcMeth]   CHAR (1)      NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [EffDate]        SMALLDATETIME NOT NULL,
    [FromCuryId]     CHAR (4)      NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [MultDiv]        CHAR (1)      NOT NULL,
    [NoteId]         INT           NOT NULL,
    [Rate]           FLOAT (53)    NOT NULL,
    [RateReciprocal] FLOAT (53)    NOT NULL,
    [RateType]       CHAR (6)      NOT NULL,
    [S4Future01]     CHAR (30)     NOT NULL,
    [S4Future02]     CHAR (30)     NOT NULL,
    [S4Future03]     FLOAT (53)    NOT NULL,
    [S4Future04]     FLOAT (53)    NOT NULL,
    [S4Future05]     FLOAT (53)    NOT NULL,
    [S4Future06]     FLOAT (53)    NOT NULL,
    [S4Future07]     SMALLDATETIME NOT NULL,
    [S4Future08]     SMALLDATETIME NOT NULL,
    [S4Future09]     INT           NOT NULL,
    [S4Future10]     INT           NOT NULL,
    [S4Future11]     CHAR (10)     NOT NULL,
    [S4Future12]     CHAR (10)     NOT NULL,
    [ToCuryId]       CHAR (4)      NOT NULL,
    [Triangulate]    CHAR (1)      NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [CuryRate0] PRIMARY KEY CLUSTERED ([FromCuryId] ASC, [ToCuryId] ASC, [RateType] ASC, [EffDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [CuryRate1]
    ON [dbo].[CuryRate]([EffDate] ASC, [FromCuryId] ASC, [ToCuryId] ASC, [RateType] ASC) WITH (FILLFACTOR = 90);

