CREATE TABLE [dbo].[cftGeneratorType] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [Description]     CHAR (30)     NOT NULL,
    [GeneratorTypeID] CHAR (2)      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftGeneratorType0] PRIMARY KEY CLUSTERED ([GeneratorTypeID] ASC) WITH (FILLFACTOR = 90)
);

