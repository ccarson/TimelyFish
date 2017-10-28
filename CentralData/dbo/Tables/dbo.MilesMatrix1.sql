CREATE TABLE [dbo].[MilesMatrix1] (
    [AddressIDFrom]       INT         NOT NULL,
    [AddressIDTo]         INT         NOT NULL,
    [OneWayMiles]         FLOAT (53)  NULL,
    [RestrictOneWayMiles] FLOAT (53)  NULL,
    [OneWayHours]         FLOAT (53)  NULL,
    [RestrictOneWayHours] FLOAT (53)  NULL,
    [OneWayMilesTest]     DECIMAL (2) NULL,
    CONSTRAINT [PK_milesmatrix1] PRIMARY KEY CLUSTERED ([AddressIDFrom] ASC, [AddressIDTo] ASC) WITH (FILLFACTOR = 90)
);

