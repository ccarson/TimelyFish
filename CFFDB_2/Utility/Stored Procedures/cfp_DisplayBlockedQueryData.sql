


CREATE PROCEDURE 
	[Utility].[cfp_DisplayBlockedQueryData]
AS
/*
************************************************************************************************************************************

  Procedure:    Utility.cfp_DisplayBlockedQueryData
     Author:    Chris Carson
    Purpose:    Display current queries, blocking queries and execution stats

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-07-12          created

    Logic Summary:


    Notes:

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

SELECT
	StartTime		= r.start_time
  , SPID 			= r.session_ID
  , DBName 			= DB_NAME( r.database_id )
  , SQLCommand 		= SUBSTRING(
							t.text
						  , ( r.statement_start_offset / 2 ) + 1
						  , CASE WHEN r.statement_end_offset = -1 OR r.statement_end_offset = 0
									THEN ( DATALENGTH( t.Text ) - r.statement_start_offset / 2 ) + 1
								 ELSE (r.statement_end_offset - r.statement_start_offset ) / 2 + 1
							END)
  , r.Status
  , r.command
  , r.wait_type
  , r.wait_time
  , r.wait_resource
  , r.last_wait_type
INTO  #current
FROM
	sys.dm_exec_requests AS r
OUTER APPLY
	sys.dm_exec_sql_text( r.sql_handle ) AS t
WHERE
	r.session_id != @@SPID 		-- exclude current query
		AND r.session_id > 50 	-- exclude system queries
ORDER BY
	r.start_time ;


SELECT
	LockType 		= t1.resource_type
  , BlockingRequest = t1.request_mode
  , DBName 			= DB_NAME( t1.resource_database_id )
  , BlockingObject 	= t1.resource_associated_entity_id
  ,	BlockingSPID 	= t2.blocking_session_id
  , BlockingSQL 	= (	SELECT
							[text]
						FROM
							sys.sysprocesses AS p
						CROSS APPLY
							sys.dm_exec_sql_text( p.sql_handle )
						WHERE
							p.spid = t2.blocking_session_id )
  , WaitingSPID 	= t1.request_session_id
  , WaitingBatch	= ( SELECT
							[text]
						FROM
							sys.dm_exec_requests AS r
						CROSS APPLY
							sys.dm_exec_sql_text( r.sql_handle )
						WHERE
							r.session_id = t1.request_session_id )
  , WaitingSQL 		= (	SELECT
							SUBSTRING( qt.[text]
										, r.statement_start_offset / 2
										, ( CASE WHEN r.statement_end_offset = -1
													THEN LEN( CONVERT( nvarchar(max), qt.[text] ) ) * 2
												 ELSE r.statement_end_offset
											END - r.statement_start_offset ) / 2 )
						FROM
							sys.dm_exec_requests AS r
						CROSS APPLY
							sys.dm_exec_sql_text( r.sql_handle ) AS qt
						WHERE r.session_id = t1.request_session_id )
  , WaitTimeMS 		=  t2.wait_duration_ms
INTO #blocking
FROM
	sys.dm_tran_locks AS t1
INNER JOIN
	sys.dm_os_waiting_tasks AS t2 ON t1.lock_owner_address = t2.resource_address


SELECT * FROM #current ORDER BY StartTime ;

SELECT * FROM #blocking ; 

SELECT * FROM sys.dm_exec_requests 
WHERE session_id IN ( SELECT BlockingSPID FROM #blocking UNION SELECT WaitingSPID FROM #blocking UNION SELECT SPID FROM #current ) ; 

SELECT * FROM sys.dm_exec_connections
WHERE session_id IN ( SELECT BlockingSPID FROM #blocking UNION SELECT WaitingSPID FROM #blocking UNION SELECT SPID FROM #current ) ; 

SELECT * FROM sys.dm_exec_sessions
WHERE session_id IN ( SELECT BlockingSPID FROM #blocking UNION SELECT WaitingSPID FROM #blocking UNION SELECT SPID FROM #current ) ; 

RETURN 0 ;



