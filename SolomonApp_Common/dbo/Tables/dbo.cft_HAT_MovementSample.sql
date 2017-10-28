CREATE TABLE [dbo].[cft_HAT_MovementSample] (
    [SPID]          INT          NOT NULL,
    [TranTypeID]    VARCHAR (2)  NOT NULL,
    [Start_DT]      DATETIME     NOT NULL,
    [Expire_DT]     DATETIME     NULL,
    [Timing]        VARCHAR (10) NOT NULL,
    [Days]          INT          NOT NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Description]   VARCHAR (30) NULL,
    CONSTRAINT [PK_cft_HAT_MovementSample] PRIMARY KEY CLUSTERED ([SPID] ASC, [TranTypeID] ASC, [Start_DT] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_ProtocolHdr_2_cft_HAT_MovementSample_SPID] FOREIGN KEY ([SPID]) REFERENCES [dbo].[cft_HAT_ProtocolHdr] ([SPID]) ON DELETE CASCADE
);

