CREATE TABLE [dbo].[PCGroup] (
    [FarmID]      VARCHAR (8)   NOT NULL,
    [GroupID]     VARCHAR (12)  NOT NULL,
    [AlternateID] VARCHAR (20)  NULL,
    [Source]      VARCHAR (20)  NULL,
    [Genetics]    VARCHAR (20)  NULL,
    [Sire]        VARCHAR (12)  NULL,
    [Dam]         VARCHAR (12)  NULL,
    [StartDate]   SMALLDATETIME NULL,
    [StartWeight] FLOAT (53)    NULL,
    [CloseDate]   SMALLDATETIME NULL,
    CONSTRAINT [PK_PCGroup] PRIMARY KEY CLUSTERED ([FarmID] ASC, [GroupID] ASC) WITH (FILLFACTOR = 90)
);

