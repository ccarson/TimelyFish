CREATE TABLE [caredata].[EV_FOSTERS] (
    [event_id]       INT          NOT NULL,
    [identity_id]    INT          NOT NULL,
    [piglets]        TINYINT      NOT NULL,
    [age]            TINYINT      NULL,
    [foster_type]    VARCHAR (3)  NULL,
    [total_weight]   FLOAT (53)   NULL,
    [other_event_id] INT          NULL,
    [UDF022680]      VARCHAR (36) NULL,
    CONSTRAINT [PK_EV_FOSTERS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_FOSTERS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_FOSTERS_BH_EVENTS_2] FOREIGN KEY ([other_event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]),
    CONSTRAINT [FK_EV_FOSTERS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);


GO
CREATE TRIGGER [caredata].[DELETE_FOSTER] ON caredata.ev_fosters AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;
  DELETE FROM caredata.bh_events WHERE event_id IN (SELECT other_event_id FROM deleted)
END
