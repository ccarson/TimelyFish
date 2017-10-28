CREATE TABLE [careglobal].[FMS_UPLOAD_HISTORY] (
    [fms_upload_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [server]        VARCHAR (70) NOT NULL,
    [username]      VARCHAR (30) NOT NULL,
    [creation_date] DATETIME     NOT NULL,
    [created_by]    VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_FMS_UPLOAD_HISTORY] PRIMARY KEY CLUSTERED ([fms_upload_id] ASC) WITH (FILLFACTOR = 90)
);

