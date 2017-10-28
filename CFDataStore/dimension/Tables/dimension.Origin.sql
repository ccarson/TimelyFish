CREATE TABLE 
	dimension.Origin(
    [OriginKey]   BIGINT        IDENTITY  NOT NULL,
    [FarmKey]     BIGINT        NOT NULL,
    [OriginName]  NVARCHAR (50) NOT NULL,
    [CreatedDate] DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]   INT           DEFAULT ((-1)) NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   INT           NULL,
    [DeletedDate] DATETIME      NULL,
    [DeletedBy]   INT           NULL,
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_Origin] PRIMARY KEY CLUSTERED ([OriginKey] ASC)
);
