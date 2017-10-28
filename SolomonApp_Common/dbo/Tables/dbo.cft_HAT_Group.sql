CREATE TABLE [dbo].[cft_HAT_Group] (
    [GroupID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]          VARCHAR (50)  NULL,
    [Active_cde]    VARCHAR (1)   NOT NULL,
    [Crtd_DateTime] DATETIME      DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50)  DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME      DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)   DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50)  DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Description]   VARCHAR (100) NULL,
    CONSTRAINT [PK_cft_HAT_Group] PRIMARY KEY CLUSTERED ([GroupID] ASC) WITH (FILLFACTOR = 90)
);

