CREATE TABLE [stage].[HDR_SOWS] (
    [ID]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [identity_id]    INT              NOT NULL,
    [genetics_id]    INT              NULL,
    [date_of_birth]  DATETIME         NULL,
    [origin_id]      INT              NULL,
    [ticket_id]      INT              NULL,
	[service_date]	 DATETIME		  NULL,
    [MFGUID]         VARCHAR (36)     NULL,
    [unique_id]		UNIQUEIDENTIFIER NULL, 
    [SourceGUID]     AS               (CONVERT([nvarchar](36),[unique_id])),
    CONSTRAINT [PK_HDR_SOWS] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
);







 


