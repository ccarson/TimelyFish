CREATE TABLE [dbo].[CuryInfo] (
    [BaseCuryID]     CHAR (4)      NOT NULL,
    [BaseDecPl]      SMALLINT      NOT NULL,
    [CuryView]       SMALLINT      NOT NULL,
    [EffDate]        SMALLDATETIME NOT NULL,
    [FieldsDisabled] SMALLINT      NOT NULL,
    [MultDiv]        CHAR (1)      NOT NULL,
    [Rate]           FLOAT (53)    NOT NULL,
    [RateType]       CHAR (6)      NOT NULL,
    [TranCuryId]     CHAR (4)      NOT NULL,
    [TranDecPl]      SMALLINT      NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [CuryInfo0] PRIMARY KEY CLUSTERED ([TranCuryId] ASC) WITH (FILLFACTOR = 90)
);

