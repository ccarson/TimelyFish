CREATE TABLE [dbo].[PJGLSORT] (
    [amount]            FLOAT (53)    NOT NULL,
    [cpnyId]            CHAR (10)     NOT NULL,
    [CuryId]            CHAR (4)      NOT NULL,
    [CuryRate]          FLOAT (53)    NOT NULL,
    [CuryRateType]      CHAR (6)      NOT NULL,
    [CuryTranAmt]       FLOAT (53)    NOT NULL,
    [data1]             CHAR (10)     NOT NULL,
    [data2]             CHAR (30)     NOT NULL,
    [drcr]              CHAR (1)      NOT NULL,
    [employee]          CHAR (10)     NOT NULL,
    [gl_acct]           CHAR (10)     NOT NULL,
    [gl_subacct]        CHAR (24)     NOT NULL,
    [glsort_key]        INT           NOT NULL,
    [li_type]           CHAR (1)      NOT NULL,
    [project]           CHAR (16)     NOT NULL,
    [pjt_entity]        CHAR (32)     NOT NULL,
    [Slsperid]          CHAR (10)     NOT NULL,
    [source_acct]       CHAR (16)     NOT NULL,
    [source_pjt_entity] CHAR (32)     NOT NULL,
    [trans_date]        SMALLDATETIME NOT NULL,
    [units]             FLOAT (53)    NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [pjglsort0] PRIMARY KEY CLUSTERED ([glsort_key] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjglsort2]
    ON [dbo].[PJGLSORT]([gl_acct] ASC, [gl_subacct] ASC) WITH (FILLFACTOR = 90);

