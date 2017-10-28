CREATE TABLE [dbo].[WrkComponent] (
    [CmpnentID]   CHAR (30)  CONSTRAINT [DF_WrkComponent_CmpnentID] DEFAULT (' ') NOT NULL,
    [CmpnentType] CHAR (1)   CONSTRAINT [DF_WrkComponent_CmpnentType] DEFAULT (' ') NOT NULL,
    [GrossReqQty] FLOAT (53) CONSTRAINT [DF_WrkComponent_GrossReqQty] DEFAULT ((0)) NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [WrkComponent0]
    ON [dbo].[WrkComponent]([CmpnentID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WrkComponent1]
    ON [dbo].[WrkComponent]([CmpnentType] ASC, [CmpnentID] ASC) WITH (FILLFACTOR = 90);

