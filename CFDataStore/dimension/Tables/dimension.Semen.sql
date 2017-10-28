CREATE TABLE [dimension].[Semen] (
    [SemenKey]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [BreederKey]    BIGINT           NOT NULL,
    [PIGCHAMP DATA] NCHAR (10)       NOT NULL,
    [SourceCode]    TINYINT          CONSTRAINT [DF__Semen__SourceCod__7EF6D905] DEFAULT ((1)) NOT NULL,
    [SourceID]      INT              NOT NULL,
    [SourceGUID]    UNIQUEIDENTIFIER CONSTRAINT [DF__Semen__SourceGUI__7FEAFD3E] DEFAULT (newsequentialid()) NOT NULL,
    CONSTRAINT [PK_Semen] PRIMARY KEY CLUSTERED ([SemenKey] ASC)
);

