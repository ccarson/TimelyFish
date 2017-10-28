CREATE TABLE [dbo].[cft_HAT_Results] (
    [CaseID]            VARCHAR (10)  NOT NULL,
    [Owner]             VARCHAR (100) NULL,
    [Lab]               VARCHAR (15)  NULL,
    [Received_DateTime] DATETIME      NULL,
    [Results_Exists]    BIT           DEFAULT ((0)) NOT NULL,
    [Results_Processed] BIT           DEFAULT ((0)) NOT NULL,
    [Results_DateTime]  DATETIME      NULL,
    [Results_XML]       XML           NULL,
    [crtd_DateTime]     DATETIME      DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]         VARCHAR (15)  DEFAULT (substring(host_name(),(1),(15))) NOT NULL,
    [crtd_User]         VARCHAR (50)  DEFAULT (substring(original_login(),(1),(50))) NOT NULL,
    [Lupd_DateTime]     DATETIME      NULL,
    [Lupd_Prog]         VARCHAR (15)  NULL,
    [Lupd_User]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_cftHATResults2] PRIMARY KEY CLUSTERED ([CaseID] ASC) WITH (FILLFACTOR = 100)
);

