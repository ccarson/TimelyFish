CREATE TABLE [stage].[SUPERVISORS] (
    [supervisor_id]    INT              NOT NULL,
    [site_id]          INT              NOT NULL,
    [initials]         VARCHAR (4)      NOT NULL,
    [last_name]        VARCHAR (30)     NULL,
    [first_name]       VARCHAR (30)     NULL,
    [description]      VARCHAR (30)     NULL,
    [mobile_user]      BIT              NOT NULL,
    [mobile_password]  VARCHAR (300)    NULL,
    [disabled]         BIT              NOT NULL,
    [synonym]          VARCHAR (5)      NULL,
    [creation_date]    DATETIME         NOT NULL,
    [created_by]       VARCHAR (15)     NOT NULL,
    [last_update_date] DATETIME         NULL,
    [last_update_by]   VARCHAR (15)     NULL,
    [deletion_date]    DATETIME         NULL,
    [deleted_by]       VARCHAR (15)     NULL,
	[unique_id]			[uniqueidentifier] NOT NULL,
    --[SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[unique_id])),
    PRIMARY KEY CLUSTERED ([supervisor_id] ASC)
);



