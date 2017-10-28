CREATE TABLE [dbo].[smWrkServCall] (
    [ExtCost]       FLOAT (53) NOT NULL,
    [RI_ID]         SMALLINT   NOT NULL,
    [ServiceCallID] CHAR (10)  NOT NULL,
    [tstamp]        ROWVERSION NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [smWrkServCall0]
    ON [dbo].[smWrkServCall]([RI_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smWrkServCall1]
    ON [dbo].[smWrkServCall]([ServiceCallID] ASC) WITH (FILLFACTOR = 90);

