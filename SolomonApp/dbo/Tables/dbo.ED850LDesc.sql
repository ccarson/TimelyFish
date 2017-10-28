CREATE TABLE [dbo].[ED850LDesc] (
    [AgencyQualCode]     CHAR (3)      CONSTRAINT [DF_ED850LDesc_AgencyQualCode] DEFAULT (' ') NOT NULL,
    [CharacteristicCode] CHAR (3)      CONSTRAINT [DF_ED850LDesc_CharacteristicCode] DEFAULT (' ') NOT NULL,
    [CpnyID]             CHAR (10)     CONSTRAINT [DF_ED850LDesc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME CONSTRAINT [DF_ED850LDesc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]          CHAR (8)      CONSTRAINT [DF_ED850LDesc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]          CHAR (10)     CONSTRAINT [DF_ED850LDesc_Crtd_User] DEFAULT (' ') NOT NULL,
    [Description]        CHAR (80)     CONSTRAINT [DF_ED850LDesc_Description] DEFAULT (' ') NOT NULL,
    [DescriptionCode]    CHAR (15)     CONSTRAINT [DF_ED850LDesc_DescriptionCode] DEFAULT (' ') NOT NULL,
    [DescriptionType]    CHAR (3)      CONSTRAINT [DF_ED850LDesc_DescriptionType] DEFAULT (' ') NOT NULL,
    [EDIPOID]            CHAR (10)     CONSTRAINT [DF_ED850LDesc_EDIPOID] DEFAULT (' ') NOT NULL,
    [LanguageCode]       CHAR (3)      CONSTRAINT [DF_ED850LDesc_LanguageCode] DEFAULT (' ') NOT NULL,
    [LineID]             INT           CONSTRAINT [DF_ED850LDesc_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]            SMALLINT      CONSTRAINT [DF_ED850LDesc_LineNbr] DEFAULT ((0)) NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME CONSTRAINT [DF_ED850LDesc_Lupd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]          CHAR (8)      CONSTRAINT [DF_ED850LDesc_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]          CHAR (10)     CONSTRAINT [DF_ED850LDesc_Lupd_User] DEFAULT (' ') NOT NULL,
    [S4Future01]         CHAR (30)     CONSTRAINT [DF_ED850LDesc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]         CHAR (30)     CONSTRAINT [DF_ED850LDesc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]         FLOAT (53)    CONSTRAINT [DF_ED850LDesc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]         FLOAT (53)    CONSTRAINT [DF_ED850LDesc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]         FLOAT (53)    CONSTRAINT [DF_ED850LDesc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]         FLOAT (53)    CONSTRAINT [DF_ED850LDesc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]         SMALLDATETIME CONSTRAINT [DF_ED850LDesc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]         SMALLDATETIME CONSTRAINT [DF_ED850LDesc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]         INT           CONSTRAINT [DF_ED850LDesc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]         INT           CONSTRAINT [DF_ED850LDesc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]         CHAR (10)     CONSTRAINT [DF_ED850LDesc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]         CHAR (10)     CONSTRAINT [DF_ED850LDesc_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]              CHAR (30)     CONSTRAINT [DF_ED850LDesc_User1] DEFAULT (' ') NOT NULL,
    [User10]             SMALLDATETIME CONSTRAINT [DF_ED850LDesc_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]              CHAR (30)     CONSTRAINT [DF_ED850LDesc_User2] DEFAULT (' ') NOT NULL,
    [User3]              CHAR (30)     CONSTRAINT [DF_ED850LDesc_User3] DEFAULT (' ') NOT NULL,
    [User4]              CHAR (30)     CONSTRAINT [DF_ED850LDesc_User4] DEFAULT (' ') NOT NULL,
    [User5]              FLOAT (53)    CONSTRAINT [DF_ED850LDesc_User5] DEFAULT ((0)) NOT NULL,
    [User6]              FLOAT (53)    CONSTRAINT [DF_ED850LDesc_User6] DEFAULT ((0)) NOT NULL,
    [User7]              CHAR (10)     CONSTRAINT [DF_ED850LDesc_User7] DEFAULT (' ') NOT NULL,
    [User8]              CHAR (10)     CONSTRAINT [DF_ED850LDesc_User8] DEFAULT (' ') NOT NULL,
    [User9]              SMALLDATETIME CONSTRAINT [DF_ED850LDesc_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [ED850LDesc0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [EDIPOID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ED850LDesc1]
    ON [dbo].[ED850LDesc]([CpnyID] ASC, [EDIPOID] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);

