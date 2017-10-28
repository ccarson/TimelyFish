CREATE TABLE [dbo].[cft_HAT_SampleTest] (
    [STID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SPID]          INT          NOT NULL,
    [TestID]        INT          NOT NULL,
    [Start_DT]      DATETIME     NOT NULL,
    [Expire_DT]     DATETIME     NULL,
    [Crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)  DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    CONSTRAINT [PK_cft_HAT_SampleTest] PRIMARY KEY CLUSTERED ([STID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_ProtocolHdr_2_cft_HAT_SampleTest_SPID] FOREIGN KEY ([SPID]) REFERENCES [dbo].[cft_HAT_ProtocolHdr] ([SPID]) ON DELETE CASCADE,
    CONSTRAINT [FK_cft_HAT_Test_2_cft_HAT_SampleTest_TestID] FOREIGN KEY ([TestID]) REFERENCES [dbo].[cft_HAT_Test] ([TestID]) ON DELETE CASCADE
);

