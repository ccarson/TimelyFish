CREATE TABLE [dbo].[BarnRoom] (
    [RoomName]   VARCHAR (15) NOT NULL,
    [BarnAutoID] INT          NOT NULL,
    [SiteID]     VARCHAR (4)  NOT NULL,
    [Comment]    VARCHAR (60) NULL,
    CONSTRAINT [PK_BarnRoom] PRIMARY KEY CLUSTERED ([RoomName] ASC, [BarnAutoID] ASC) WITH (FILLFACTOR = 90)
);

