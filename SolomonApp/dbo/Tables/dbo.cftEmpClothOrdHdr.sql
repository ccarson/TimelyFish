CREATE TABLE [dbo].[cftEmpClothOrdHdr] (
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [EmpID]          INT           NOT NULL,
    [EmpName]        CHAR (30)     NOT NULL,
    [InvoiceNbr]     CHAR (10)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [OrderDate]      SMALLDATETIME NOT NULL,
    [OrdNbr]         CHAR (10)     NOT NULL,
    [OrdTotAmt]      FLOAT (53)    NOT NULL,
    [Received]       SMALLINT      NOT NULL,
    [ShipToLocation] CHAR (10)     NOT NULL,
    [tstamp]         ROWVERSION    NULL
);

