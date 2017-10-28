CREATE TABLE [dbo].[cft_HAT_Lab_Test_Map] (
    [MapID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TestID]        INT           NOT NULL,
    [LabID]         INT           NOT NULL,
    [Name]          VARCHAR (100) NOT NULL,
    [Specimen]      VARCHAR (50)  NULL,
    [Crtd_DateTime] DATETIME      NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   NOT NULL,
    [Crtd_User]     VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_cft_HAT_Lab_Test_Map] PRIMARY KEY CLUSTERED ([MapID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_Lab_Test_Map_2_cft_HAT_Lab_CaseID] FOREIGN KEY ([LabID]) REFERENCES [dbo].[cft_HAT_Lab] ([LabID]) ON DELETE CASCADE,
    CONSTRAINT [FK_cft_HAT_Lab_Test_Map_2_cft_HAT_Results_TestID] FOREIGN KEY ([TestID]) REFERENCES [dbo].[cft_HAT_Test] ([TestID]) ON DELETE CASCADE
);

