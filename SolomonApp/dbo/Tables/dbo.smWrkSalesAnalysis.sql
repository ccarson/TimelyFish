CREATE TABLE [dbo].[smWrkSalesAnalysis] (
    [CallType]          CHAR (10)  NOT NULL,
    [CurCost]           FLOAT (53) NOT NULL,
    [CurHours]          FLOAT (53) NOT NULL,
    [CurNbrCalls]       SMALLINT   NOT NULL,
    [CurRevenue]        FLOAT (53) NOT NULL,
    [CustClass]         CHAR (6)   NOT NULL,
    [InvoiceType]       CHAR (1)   NOT NULL,
    [PrintMonth]        SMALLINT   NOT NULL,
    [PrintYear]         SMALLINT   NOT NULL,
    [PriorCost]         FLOAT (53) NOT NULL,
    [PriorHours]        FLOAT (53) NOT NULL,
    [PriorNbrCalls]     SMALLINT   NOT NULL,
    [PriorRevenue]      FLOAT (53) NOT NULL,
    [RecType]           CHAR (1)   NOT NULL,
    [RI_ID]             SMALLINT   NOT NULL,
    [ServiceCallID]     CHAR (10)  NOT NULL,
    [ServiceContractId] CHAR (10)  NOT NULL,
    [tstamp]            ROWVERSION NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [smWrkSalesAnalysis0]
    ON [dbo].[smWrkSalesAnalysis]([RecType] ASC, [CallType] ASC, [CustClass] ASC, [InvoiceType] ASC, [ServiceCallID] ASC) WITH (FILLFACTOR = 90);

