CREATE TABLE [dbo].[BarnGating] (
    [Description] VARCHAR (30) NOT NULL,
    [BarnAutoID]  INT          NOT NULL,
    [SiteID]      VARCHAR (4)  NOT NULL,
    [Height]      FLOAT (53)   NULL,
    [Length]      FLOAT (53)   NULL,
    [Vendor]      VARCHAR (30) NULL,
    [Qty]         INT          NULL,
    CONSTRAINT [PK_BarnGating] PRIMARY KEY CLUSTERED ([Description] ASC, [BarnAutoID] ASC) WITH (FILLFACTOR = 90)
);

