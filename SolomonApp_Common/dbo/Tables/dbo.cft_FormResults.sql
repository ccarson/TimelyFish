CREATE TABLE [dbo].[cft_FormResults] (
    [Crtd_DateTime]   DATETIME      NOT NULL,
    [FormId]          INT           NOT NULL,
    [FormName]        VARCHAR (100) NULL,
    [ReferenceNumber] VARCHAR (25)  NOT NULL,
    [Results_XML]     XML           NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [cft_FormResults0] PRIMARY KEY CLUSTERED ([ReferenceNumber] ASC) WITH (FILLFACTOR = 90)
);

