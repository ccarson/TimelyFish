CREATE TABLE [dbo].[SI21690_Wrk] (
    [RI_ID]           SMALLINT   NOT NULL,
    [TaxId]           CHAR (10)  NOT NULL,
    [Descr]           CHAR (30)  NOT NULL,
    [SlsTaxGrp_TaxId] CHAR (10)  NOT NULL,
    [SlsTax1_Descr]   CHAR (30)  NOT NULL,
    [SlsTax1_TaxRate] FLOAT (53) NOT NULL,
    [tstamp]          ROWVERSION NOT NULL
);

