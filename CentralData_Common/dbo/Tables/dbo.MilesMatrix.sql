CREATE TABLE [dbo].[MilesMatrix] (
    [AddressIDFrom]       INT           NOT NULL,
    [AddressIDTo]         INT           NOT NULL,
    [OneWayMiles]         FLOAT (53)    NULL,
    [RestrictOneWayMiles] FLOAT (53)    NULL,
    [OneWayHours]         FLOAT (53)    NULL,
    [RestrictOneWayHours] FLOAT (53)    NULL,
    [OneWayMilesTest]     NUMERIC (2)   NULL,
    [OverRide]            SMALLINT      CONSTRAINT [DF_MilesMatrix_OverRide] DEFAULT (0) NULL,
    [Directions]          VARCHAR (MAX) NULL,
    CONSTRAINT [PK_MilesMatrix] PRIMARY KEY CLUSTERED ([AddressIDFrom] ASC, [AddressIDTo] ASC) WITH (FILLFACTOR = 100)
);
