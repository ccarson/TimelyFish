CREATE TABLE [stage].[BH_IDENTITIES] (
    [identity_id]   INT          NOT NULL,
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
    [unique_id] UNIQUEIDENTIFIER NULL, 
    CONSTRAINT PK_BH_IDENTITIES 
		PRIMARY KEY CLUSTERED ( identity_id ASC) WITH (FILLFACTOR = 90 )
);

GO

CREATE UNIQUE NONCLUSTERED INDEX IX_BH_IDENTITIES_01 
	ON stage.BH_IDENTITIES( identity_id ) 
		WITH (SORT_IN_TEMPDB = ON, FILLFACTOR = 90 ) ;


