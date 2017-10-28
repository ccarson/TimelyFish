CREATE TABLE [dbo].[cftPfosSite] (
    [Crtd_dateTime]   DATETIME     NOT NULL,
    [Crtd_User]       VARCHAR (20) NOT NULL,
    [Eff_dateTime]    DATETIME     NOT NULL,
    [Expire_dateTime] DATETIME     NULL,
    [Lupd_dateTime]   DATETIME     NULL,
    [Lupd_User]       VARCHAR (20) NULL,
    [ContactID]       INT          NOT NULL,
    [Tstamp]          ROWVERSION   NOT NULL,
    CONSTRAINT [PK_cftPfosSite] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Site] ([ContactID])
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[cftPfosSite] TO [SLWSAPP]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[cftPfosSite] TO [SLWSAPP]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[cftPfosSite] TO [SLWSAPP]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftPfosSite] TO [SLWSAPP]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[cftPfosSite] TO [SLWSAPP]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftPfosSite] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftPfosSite] TO [E8F575915A2E4897A517779C0DD7CE]
    AS [dbo];

