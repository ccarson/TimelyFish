CREATE TABLE [dbo].[cftContactAddress] (
    [AddressID]     CHAR (6)      NOT NULL,
    [AddressTypeID] CHAR (2)      NOT NULL,
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftContactAddress0] PRIMARY KEY CLUSTERED ([ContactID] ASC, [AddressTypeID] ASC, [AddressID] ASC) WITH (FILLFACTOR = 90)
);

