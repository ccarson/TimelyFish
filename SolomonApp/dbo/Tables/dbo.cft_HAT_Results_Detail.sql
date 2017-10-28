CREATE TABLE [dbo].[cft_HAT_Results_Detail] (
    [ResultsID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CaseID]        VARCHAR (10) NOT NULL,
    [TestID]        INT          NOT NULL,
    [Results]       VARCHAR (8)  NOT NULL,
    [crtd_DateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (15) DEFAULT (substring(host_name(),(1),(15))) NOT NULL,
    [crtd_User]     VARCHAR (50) DEFAULT (substring(original_login(),(1),(50))) NOT NULL,
    [Lupd_DateTime] DATETIME     NULL,
    [Lupd_Prog]     VARCHAR (15) NULL,
    [Lupd_User]     VARCHAR (50) NULL,
    CONSTRAINT [PK_cftHATResults] PRIMARY KEY CLUSTERED ([ResultsID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_cft_HAT_Results_2_cft_HAT_Results_Detail_CaseID] FOREIGN KEY ([CaseID]) REFERENCES [dbo].[cft_HAT_Results] ([CaseID]),
    CONSTRAINT [FK_cft_HAT_Test_2_cft_HAT_Results_TestID] FOREIGN KEY ([TestID]) REFERENCES [dbo].[cft_HAT_Test] ([TestID])
);

