CREATE TABLE [dbo].[cftContactPhone] (
    [Comment]       CHAR (50)     NULL,
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [PhoneID]       CHAR (6)      NOT NULL,
    [PhoneTypeID]   CHAR (3)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [IDX_cftContactPhone_PK] PRIMARY KEY CLUSTERED ([ContactID] ASC, [PhoneID] ASC, [PhoneTypeID] ASC) WITH (FILLFACTOR = 90)
);

