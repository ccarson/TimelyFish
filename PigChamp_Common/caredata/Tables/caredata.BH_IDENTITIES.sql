CREATE TABLE [caredata].[BH_IDENTITIES] (
    [identity_id]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [identity_type] VARCHAR (1)  NOT NULL,
    [transponder]   VARCHAR (20) NULL,
    [tattoo]        VARCHAR (15) NULL,
    [govt_identity] VARCHAR (25) NULL,
    [usda_ain]      VARCHAR (15) NULL,
    [alt_id1]       VARCHAR (20) NULL,
    [alt_id2]       VARCHAR (20) NULL,
    [alt_id3]       VARCHAR (20) NULL,
    [mobile_id]     VARCHAR (20) NULL,
    [audit_time]    DATETIME     NULL,
    CONSTRAINT [PK_BH_IDENTITIES] PRIMARY KEY CLUSTERED ([identity_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IDX_BH_IDENTITIES_Tattoo]
    ON [caredata].[BH_IDENTITIES]([tattoo] ASC) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [caredata].[DELETE_IDENTITY] ON caredata.bh_identities AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE caredata.ev_nurse_on SET fostered_from_identity_id = NULL WHERE fostered_from_identity_id IN (SELECT identity_id FROM deleted)
  UPDATE caredata.ev_matings SET male_identity_id = NULL WHERE male_identity_id IN (SELECT identity_id FROM deleted)
END
