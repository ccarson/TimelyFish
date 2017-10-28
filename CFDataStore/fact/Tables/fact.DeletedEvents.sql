CREATE TABLE [fact].[DeletedEvents]
(
	[event_id] [int] NOT NULL,
	[site_id] [int] NULL,
	[identity_id] [int] NULL,
	[event_type] [smallint] NULL,
	[eventdate] [datetime] NULL,
	[deletion_date] [datetime] NULL,
	[deleted_by] [varchar](15) NULL,
	[SourceCode] [nvarchar](20) NULL,
	[DSAnimalKey] [bigint] NULL,
	[MFAnimalGUID] [nvarchar](36) NULL,
	[DSFarmKey] [bigint] NULL,
	[MFFarmGUID] [nvarchar](36) NULL,
	[DSEventKey] [bigint] NULL,
	[MFEventGUID] [nvarchar](36) NULL
	CONSTRAINT [PK_FACT_DELETED_EVENTS] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [fact].[DeletedEvents] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);