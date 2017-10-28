CREATE TABLE [dbo].[Bin] (
    [BinID]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BinNbr]       VARCHAR (10) NOT NULL,
    [FeedingLevel] VARCHAR (10) NOT NULL,
    [BarnID]       INT          NULL,
    [RoomID]       INT          NULL,
    [ContactID]    INT          NULL,
    [BinTypeID]    INT          NULL,
    [Active]       SMALLINT     CONSTRAINT [DF_Bin_Active] DEFAULT ((-1)) NULL,
    [BinSortOrder] INT          NULL,
    CONSTRAINT [PK_Bin] PRIMARY KEY CLUSTERED ([BinID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [BinNbr/ContactID]
    ON [dbo].[Bin]([BinNbr] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90);
