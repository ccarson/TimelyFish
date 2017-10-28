CREATE TABLE [dbo].[cft_scribe_CRM_workorder_Dups] (
    [ServiceCallID]          CHAR (10)      NOT NULL,
    [CpnyID]                 CHAR (10)      NULL,
    [CallStatus]             CHAR (10)      NULL,
    [CallType]               CHAR (10)      NULL,
    [calltypedesc]           VARCHAR (30)   NULL,
    [preferredtech]          VARCHAR (6)    NULL,
    [CallerName]             CHAR (60)      NULL,
    [callerphone]            VARCHAR (30)   NULL,
    [ProjectID]              CHAR (16)      NULL,
    [CustomerId]             CHAR (15)      NULL,
    [name]                   VARCHAR (60)   NULL,
    [service_acct_siteid]    VARCHAR (6)    NULL,
    [service_acct_contactid] VARCHAR (6)    NULL,
    [service_acct_name]      VARCHAR (60)   NULL,
    [ServiceCallPriority]    VARCHAR (1)    NULL,
    [ServiceCallStatus]      CHAR (1)       NULL,
    [SALDateTime]            SMALLDATETIME  NULL,
    [DueDateTime]            SMALLDATETIME  NULL,
    [work_order_summary]     VARCHAR (8000) NULL,
    [crtd_datetime]          SMALLDATETIME  NULL,
    [crtd_user]              VARCHAR (50)   NULL
);

