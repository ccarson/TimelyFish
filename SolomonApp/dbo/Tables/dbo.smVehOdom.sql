CREATE TABLE [dbo].[smVehOdom] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [EmpID]           CHAR (10)     NOT NULL,
    [LineNbr]         SMALLINT      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [VehicleID]       CHAR (10)     NOT NULL,
    [VehicleOdometer] FLOAT (53)    NOT NULL,
    [VehicleReadDate] SMALLDATETIME NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [smVehOdom0] PRIMARY KEY CLUSTERED ([VehicleID] ASC, [EmpID] ASC, [VehicleReadDate] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smVehOdom1]
    ON [dbo].[smVehOdom]([VehicleID] ASC, [VehicleReadDate] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smVehOdom2]
    ON [dbo].[smVehOdom]([EmpID] ASC, [VehicleReadDate] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);

