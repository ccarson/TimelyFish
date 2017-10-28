CREATE TABLE [dbo].[cftLWYield] (
    [EffMonth]        SMALLINT   NOT NULL,
    [PigGenderTypeID] CHAR (6)   NOT NULL,
    [Yield]           FLOAT (53) NULL,
    [tstamp]          ROWVERSION NULL,
    CONSTRAINT [cftLWYield0] PRIMARY KEY CLUSTERED ([PigGenderTypeID] ASC, [EffMonth] ASC) WITH (FILLFACTOR = 90)
);

