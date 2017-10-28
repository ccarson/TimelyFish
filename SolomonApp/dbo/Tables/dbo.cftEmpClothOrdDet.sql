CREATE TABLE [dbo].[cftEmpClothOrdDet] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EmpID]         INT           NOT NULL,
    [ItemDescr]     CHAR (50)     NOT NULL,
    [ItemNbr]       CHAR (20)     NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [Qty]           SMALLINT      NOT NULL,
    [TotPrice]      FLOAT (53)    NOT NULL,
    [UnitPrice]     FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL
);

