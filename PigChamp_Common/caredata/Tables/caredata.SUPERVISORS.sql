CREATE TABLE [caredata].[SUPERVISORS] (
    [supervisor_id]    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT           NOT NULL,
    [initials]         VARCHAR (4)   NOT NULL,
    [last_name]        VARCHAR (30)  NULL,
    [first_name]       VARCHAR (30)  NULL,
    [description]      VARCHAR (30)  NULL,
    [mobile_user]      BIT           CONSTRAINT [DF_SUPERVISORS_mobile_user] DEFAULT ((0)) NOT NULL,
    [mobile_password]  VARCHAR (300) NULL,
    [disabled]         BIT           CONSTRAINT [DF_SUPERVISORS_disabled] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)   NULL,
    [creation_date]    DATETIME      CONSTRAINT [DF_SUPERVISORS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15)  CONSTRAINT [DF_SUPERVISORS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME      NULL,
    [last_update_by]   VARCHAR (15)  NULL,
    [deletion_date]    DATETIME      NULL,
    [deleted_by]       VARCHAR (15)  NULL,
    CONSTRAINT [PK_SUPERVISORS] PRIMARY KEY CLUSTERED ([supervisor_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_SUPERVISORS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_SUPERVISORS_0]
    ON [caredata].[SUPERVISORS]([initials] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

