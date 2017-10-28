CREATE TABLE [dbo].[BinInfo] (
    [BarnID]    INT          NOT NULL,
    [BinNumber] VARCHAR (10) NOT NULL,
    [ContactID] INT          NULL,
    [SiteID]    VARCHAR (4)  NOT NULL,
    [BinTypeID] INT          NULL,
    CONSTRAINT [PK_BinInfo] PRIMARY KEY CLUSTERED ([BinNumber] ASC, [BarnID] ASC) WITH (FILLFACTOR = 90)
);

