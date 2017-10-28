CREATE TABLE [dbo].[cftMilesMatrix] (
    [AddressIDFrom]       CHAR (6)      NOT NULL,
    [AddressIDTo]         CHAR (6)      NOT NULL,
    [Crtd_DateTime]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]           CHAR (8)      NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [Lupd_DateTime]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [OneWayHours]         FLOAT (53)    NOT NULL,
    [OneWayMiles]         FLOAT (53)    NOT NULL,
    [OneWayMilesTest]     CHAR (5)      NOT NULL,
    [OverRide]            SMALLINT      NOT NULL,
    [RestrictOneWayHours] FLOAT (53)    NOT NULL,
    [RestrictOneWayMiles] FLOAT (53)    NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [cftMilesMatrix0] PRIMARY KEY CLUSTERED ([AddressIDFrom] ASC, [AddressIDTo] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [idx_cftmilesmatrix_addressidto_incl]
    ON [dbo].[cftMilesMatrix]([AddressIDTo] ASC)
    INCLUDE([AddressIDFrom], [OneWayHours], [tstamp]) WITH (FILLFACTOR = 90);

