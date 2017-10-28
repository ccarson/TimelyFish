CREATE TABLE [dbo].[smWrkWeekly] (
    [BillHours]     FLOAT (53)    NOT NULL,
    [EarningType]   CHAR (10)     NOT NULL,
    [EarnMult]      FLOAT (53)    NOT NULL,
    [InvAmt]        FLOAT (53)    NOT NULL,
    [InvCost]       FLOAT (53)    NOT NULL,
    [InvGM]         FLOAT (53)    NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [ServiceCallID] CHAR (10)     NOT NULL,
    [Supervisor]    CHAR (10)     NOT NULL,
    [SVFirstName]   CHAR (16)     NOT NULL,
    [SVLastName]    CHAR (16)     NOT NULL,
    [SVMidName]     CHAR (2)      NOT NULL,
    [TechFirstName] CHAR (60)     NOT NULL,
    [TechLastName]  CHAR (60)     NOT NULL,
    [TechMidName]   CHAR (60)     NOT NULL,
    [Technician]    CHAR (10)     NOT NULL,
    [TotalCost]     FLOAT (53)    NOT NULL,
    [TranDate]      SMALLDATETIME NOT NULL,
    [WorkHours]     FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [smWrkWeekly0]
    ON [dbo].[smWrkWeekly]([RI_ID] ASC, [ServiceCallID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smWrkWeekly1]
    ON [dbo].[smWrkWeekly]([ServiceCallID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smWrkWeekly2]
    ON [dbo].[smWrkWeekly]([Technician] ASC, [ServiceCallID] ASC, [EarningType] ASC) WITH (FILLFACTOR = 90);

