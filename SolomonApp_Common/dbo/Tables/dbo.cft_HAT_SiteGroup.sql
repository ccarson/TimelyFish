CREATE TABLE [dbo].[cft_HAT_SiteGroup] (
    [GroupID]       INT          NOT NULL,
    [ContactID]     CHAR (6)     NOT NULL,
    [Start_DT]      DATETIME     NOT NULL,
    [Expire_DT]     DATETIME     NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    CONSTRAINT [PK_cft_HAT_SiteGroup] PRIMARY KEY CLUSTERED ([GroupID] ASC, [ContactID] ASC, [Start_DT] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_Group_CftContactID] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[cftContact] ([ContactID]),
    CONSTRAINT [FK_cft_HAT_Group_GroupID] FOREIGN KEY ([GroupID]) REFERENCES [dbo].[cft_HAT_Group] ([GroupID]) ON DELETE CASCADE
);

