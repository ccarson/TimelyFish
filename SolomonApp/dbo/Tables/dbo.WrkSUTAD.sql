CREATE TABLE [dbo].[WrkSUTAD] (
    [CpnyID]           CHAR (10)     NOT NULL,
    [EmployeeEndDate]  SMALLDATETIME NOT NULL,
    [EmployeeId]       CHAR (10)     NOT NULL,
    [EmployeeName]     CHAR (60)     NOT NULL,
    [EmployeeSSN]      CHAR (9)      NOT NULL,
    [QTDFICAWages]     FLOAT (53)    NOT NULL,
    [QTDNonWageIncome] FLOAT (53)    NOT NULL,
    [QTDPensionAmount] FLOAT (53)    NOT NULL,
    [QTDStateWages]    FLOAT (53)    NOT NULL,
    [QTDTaxableWages]  FLOAT (53)    NOT NULL,
    [SUTATax]          FLOAT (53)    NOT NULL,
    [UserId]           CHAR (47)     NOT NULL,
    [YTDFICAWages]     FLOAT (53)    NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [WrkSUTAD0] PRIMARY KEY CLUSTERED ([UserId] ASC, [EmployeeId] ASC) WITH (FILLFACTOR = 90)
);

