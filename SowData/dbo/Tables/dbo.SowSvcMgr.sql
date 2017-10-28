CREATE TABLE [dbo].[SowSvcMgr] (
    [ContactID]    INT          NOT NULL,
    [HyperionCode] VARCHAR (10) NULL,
    CONSTRAINT [PK_SowSvcMgr] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

