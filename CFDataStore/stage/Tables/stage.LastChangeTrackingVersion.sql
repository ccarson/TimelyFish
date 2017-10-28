CREATE TABLE [stage].[LastChangeTrackingVersion] (
	ID								INT			NOT NULL	IDENTITY
  , DatabaseName					SYSNAME		NOT NULL
  , LastChangeTrackingVersion		BIGINT		NOT NULL
  , LastChangeAppliedDate			DATETIME	NOT NULL	DEFAULT GETDATE() 
  , CONSTRAINT [pkLastChangeTrackingVersion] 
		PRIMARY KEY CLUSTERED ( ID DESC)
);

