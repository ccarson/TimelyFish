CREATE TABLE [dbo].[cft_HAT_Sample] (
    [SampleID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]          VARCHAR (25) NOT NULL,
    [Method]        VARCHAR (25) NOT NULL,
    [Active_cde]    VARCHAR (1)  NOT NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    CONSTRAINT [PK_cft_HAT_Sample] PRIMARY KEY CLUSTERED ([SampleID] ASC) WITH (FILLFACTOR = 90)
);

