CREATE TABLE [dbo].[cftJobLocation] (
    [Description]     CHAR (30)  NOT NULL,
    [JobLocationCode] CHAR (20)  NOT NULL,
    [ShipToLocation]  CHAR (20)  NOT NULL,
    [tstamp]          ROWVERSION NOT NULL
);

