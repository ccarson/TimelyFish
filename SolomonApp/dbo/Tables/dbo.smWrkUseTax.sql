CREATE TABLE [dbo].[smWrkUseTax] (
    [CompleteDate]  SMALLDATETIME NOT NULL,
    [Cost]          FLOAT (53)    NOT NULL,
    [CustID]        CHAR (15)     NOT NULL,
    [InvtId]        CHAR (20)     NOT NULL,
    [LineTypes]     CHAR (1)      NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [PostToPeriod]  CHAR (6)      NOT NULL,
    [Quantity]      FLOAT (53)    NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [ServiceCallID] CHAR (10)     NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL,
    [StdCost]       FLOAT (53)    NOT NULL,
    [TaxAmt]        FLOAT (53)    NOT NULL,
    [TaxID]         CHAR (10)     NOT NULL,
    [TxblAmt]       FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [smWrkUseTax0]
    ON [dbo].[smWrkUseTax]([RI_ID] ASC, [ServiceCallID] ASC) WITH (FILLFACTOR = 90);

