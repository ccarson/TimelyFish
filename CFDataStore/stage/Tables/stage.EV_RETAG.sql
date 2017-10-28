CREATE TABLE [stage].[EV_RETAG] (
    [event_id]             INT          NOT NULL,
    [identity_id]          INT          NOT NULL,
    [eventdate]            DATETIME     NOT NULL,
    [new_primary_identity] VARCHAR (15) NOT NULL,
    [old_primary_identity] VARCHAR (15) NOT NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               CONVERT( nvarchar(36), SequentialGUID ) PERSISTED ,
    CONSTRAINT [PK_EV_RETAG] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);



