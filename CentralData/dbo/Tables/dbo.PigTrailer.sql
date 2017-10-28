CREATE TABLE [dbo].[PigTrailer] (
    [PigTrailerID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PigTrailerDescription] VARCHAR (15) NULL,
    [PigTrailerTypeID]      INT          NULL,
    [CompanyOwnedFlag]      SMALLINT     NULL,
    [InternalRampFlag]      SMALLINT     NULL,
    [TruckWashFlag]         SMALLINT     NULL,
    [StatusTypeID]          INT          CONSTRAINT [DF_PigTrailer_StautsTypeID] DEFAULT (1) NULL,
    [TrailerWashContactID]  INT          NULL,
    [ConvertPigTrailer]     CHAR (1)     NULL,
    CONSTRAINT [PK_PigTrailer] PRIMARY KEY CLUSTERED ([PigTrailerID] ASC) WITH (FILLFACTOR = 90)
);

