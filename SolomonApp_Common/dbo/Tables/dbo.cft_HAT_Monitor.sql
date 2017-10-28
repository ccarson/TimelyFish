CREATE TABLE [dbo].[cft_HAT_Monitor] (
    [SPID]          INT          NOT NULL,
    [Start_DT]      DATETIME     NOT NULL,
    [Expire_DT]     DATETIME     NULL,
    [Frequency]     VARCHAR (50) NOT NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    CONSTRAINT [PK_cft_HAT_Monitor] PRIMARY KEY CLUSTERED ([SPID] ASC, [Start_DT] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_ProtocolHdr_2_cft_HAT_Monitor_SPID] FOREIGN KEY ([SPID]) REFERENCES [dbo].[cft_HAT_ProtocolHdr] ([SPID]) ON DELETE CASCADE
);

