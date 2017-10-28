CREATE TABLE [dbo].[smWrkExpire] (
    [ActBilled]   FLOAT (53) NOT NULL,
    [ActCalls]    SMALLINT   NOT NULL,
    [ActHours]    FLOAT (53) NOT NULL,
    [ActLabor]    FLOAT (53) NOT NULL,
    [ActMaterial] FLOAT (53) NOT NULL,
    [ContractID]  CHAR (10)  NOT NULL,
    [EstBilled]   FLOAT (53) NOT NULL,
    [EstCalls]    SMALLINT   NOT NULL,
    [EstHours]    FLOAT (53) NOT NULL,
    [EstLabor]    FLOAT (53) NOT NULL,
    [EstMaterial] FLOAT (53) NOT NULL,
    [RI_ID]       SMALLINT   NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [smWrkExpire0]
    ON [dbo].[smWrkExpire]([ContractID] ASC) WITH (FILLFACTOR = 90);

