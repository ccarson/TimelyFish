CREATE TABLE [stage].[DeletedEvents]
(
	[event_id] [int] NOT NULL,
	[identity_id] [int] NULL,
	[event_type] [smallint] NULL,
	[eventdate] [datetime] NULL,
	[MFAnimalGUID] [nvarchar](36) NULL,
	[MFEventGUID] [nvarchar](36) NULL
CONSTRAINT [PK_STAGE_DELETED_EVENTS] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
