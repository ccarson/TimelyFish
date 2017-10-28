CREATE TABLE [dbo].[cft_HAT_Lab] (
    [LabID]         INT          NOT NULL,
    [Name]          VARCHAR (25) NOT NULL,
    [Active_cde]    VARCHAR (1)  NOT NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(50))) NOT NULL,
    [Lupd_DateTime] DATETIME     NULL,
    [Lupd_Prog]     VARCHAR (8)  NULL,
    [Lupd_User]     VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_HAT_Lab] PRIMARY KEY CLUSTERED ([LabID] ASC) WITH (FILLFACTOR = 90)
);

