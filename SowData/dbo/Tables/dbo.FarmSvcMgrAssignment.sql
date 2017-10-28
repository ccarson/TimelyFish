CREATE TABLE [dbo].[FarmSvcMgrAssignment] (
    [FarmID]        VARCHAR (8)   NOT NULL,
    [EffectiveDate] SMALLDATETIME NOT NULL,
    [ContactID]     INT           NOT NULL,
    CONSTRAINT [PK_FarmSvcMgrAssignment] PRIMARY KEY CLUSTERED ([FarmID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

