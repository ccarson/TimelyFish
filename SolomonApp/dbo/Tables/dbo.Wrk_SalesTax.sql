CREATE TABLE [dbo].[Wrk_SalesTax] (
    [CpnyID]        CHAR (10)       NOT NULL,
    [RecordID]      INT             NOT NULL,
    [RefNbr]        CHAR (10)       NOT NULL,
    [DocType]       CHAR (2)        NOT NULL,
    [TaxID]         CHAR (10)       NOT NULL,
    [TaxRate]       DECIMAL (9, 6)  NOT NULL,
    [TaxCalcType]   CHAR (1)        NOT NULL,
    [Acct]          CHAR (10)       NOT NULL,
    [Sub]           CHAR (24)       NOT NULL,
    [YrMon]         CHAR (6)        NOT NULL,
    [CuryTaxTot]    DECIMAL (28, 3) NOT NULL,
    [CuryTxblTot]   DECIMAL (28, 3) NOT NULL,
    [TaxTot]        DECIMAL (28, 3) NOT NULL,
    [TxblTot]       DECIMAL (28, 3) NOT NULL,
    [GrpTaxID]      CHAR (10)       NOT NULL,
    [GrpRate]       DECIMAL (9, 6)  NOT NULL,
    [GrpTaxTot]     DECIMAL (28, 3) NOT NULL,
    [GrpCuryTaxTot] DECIMAL (28, 3) NOT NULL,
    [CustVend]      CHAR (15)       NOT NULL,
    [CuryDecPl]     INT             NOT NULL,
    [UserAddress]   CHAR (21)       NOT NULL,
    [ProjectID]     CHAR (16)       NOT NULL,
    [TaskID]        CHAR (32)       NOT NULL,
    CONSTRAINT [Wrk_SalesTax0] PRIMARY KEY CLUSTERED ([UserAddress] ASC, [RecordID] ASC, [TaxID] ASC, [RefNbr] ASC, [GrpTaxID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Wrk_SalesTax1]
    ON [dbo].[Wrk_SalesTax]([RecordID] ASC);


GO
CREATE NONCLUSTERED INDEX [Wrk_SalesTax2]
    ON [dbo].[Wrk_SalesTax]([GrpTaxID] ASC);

