CREATE TABLE [dbo].[cftPfosADFI] (
    [ADFIID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ADFI]   FLOAT (53)   NOT NULL,
    [age]    INT          NOT NULL,
    [Type]   VARCHAR (10) NULL,
    [wgt]    INT          NOT NULL,
    [wk]     INT          NOT NULL,
    CONSTRAINT [cftPfosADFI0] PRIMARY KEY CLUSTERED ([ADFIID] ASC) WITH (FILLFACTOR = 90)
);

