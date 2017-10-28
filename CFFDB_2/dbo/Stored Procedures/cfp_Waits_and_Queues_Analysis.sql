
CREATE PROCEDURE [dbo].[cfp_Waits_and_Queues_Analysis]
	@TopN int = 5, -- Top N wait time percentage
	@DeltaMinutes datetime = NULL -- HH:MM:SS format, don't include date
AS

--'==========================================================================
--'
--' NAME: usp_Waits_and_Queues_Analysis_SQL2005
--'
--' AUTHOR: Joe Sack, Microsoft Corporation
--' URL: http://www.microsoft.com
--' DATE  : 11/7/2008
--' COPYRIGHT (c) 2008 All Rights Reserved
--'
--' COMMENT: Evaluate Waits and Queues on a SQL Server instance.  If
--'			 @DeltaMinutes used - collects delta between execution time
--'			 and number of minutes designated.
--'
--'
--' USAGE: Executing this procedure without parameters will produce a real-time snapshot
--'        of wait statistics as of the last SQL Server instance restart or 
--'        DBCC SQLPERF('waitstats',clear) operation.  The output of this procedure will give direct 
--'        recommendations on the next steps you should take based on the TOP X wait types.
--'
--'        Designating a @DeltaMinutes value will allow you to capture accumulated
--'        wait types between execution and the number of minutes you designate.  If you 
--'        have an existing application process that is currently executing, this would
--'        allow you to show the TOP X wait types over the designated period of time.  
--'        The output of this procedure will give direct recommendations on the next steps you 
--'        should take based on the TOP X wait types.
--'
--'	   You can set the top number of wait types to consider by setting the @TopN input parameter.
--'        You can designate the number of minutes to collect using the @DeltaMinutes input parameter.
--'        @DeltaMinutes expects a HH:MM:SS format.  Don't include date.  Use single ticks around the
--'	   HH:MM:SS format.  For example - three minutes is - '00:03:00'. 
--'
--'    THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
--'    ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
--'    THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
--'    PARTICULAR PURPOSE.
--'
--'    IN NO EVENT SHALL MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS 
--'    BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY
--'    DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
--'    WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
--'    ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
--'    OF THIS CODE OR INFORMATION.
--'
--'    Wait type descriptions/remediation quoted from Microsoft White Paper:
--'    "SQL Server 2005 Waits and Queues: SQL Server Best Practices Article'
--'==========================================================================

SET NOCOUNT ON

BEGIN TRY

--'===================================
--'	Wait Statistics
--'===================================

DECLARE @dm_os_wait_stats_original TABLE
		(wait_type nvarchar(60),
		waiting_tasks_count bigint,
		wait_time_ms bigint,
		max_wait_time_ms bigint,
		signal_wait_time_ms bigint)
 
DECLARE @dm_os_wait_stats_delta TABLE
		(wait_type nvarchar(60),
		waiting_tasks_count bigint,
		wait_time_ms bigint,
		max_wait_time_ms bigint,
		signal_wait_time_ms bigint)
		
DECLARE @dm_os_wait_stats_recommendations TABLE
		(wait_type nvarchar(60) NOT NULL,
		next_step_desc nvarchar(max) NULL)

DECLARE @wait_type_action TABLE
		(wait_type nvarchar(60) NOT NULL,
		 next_step_desc nvarchar(max) NULL)
		 
DECLARE @sum_wait_time_ms bigint,
		@start_time datetime,
		@LockMsg nvarchar(max) -- Used for repeating wait type locking description later on

SELECT	@start_time = GETDATE()
		
-- Capture current wait stats as baseline
INSERT @dm_os_wait_stats_original
SELECT wait_type,
		waiting_tasks_count,
		wait_time_ms,
		max_wait_time_ms,
		signal_wait_time_ms
FROM sys.dm_os_wait_stats

IF @DeltaMinutes IS NOT NULL
BEGIN

	WAITFOR DELAY @DeltaMinutes;

	-- Collect second wait stats result set
	INSERT @dm_os_wait_stats_delta
	SELECT wait_type,
			waiting_tasks_count,
			wait_time_ms,
			max_wait_time_ms,
			signal_wait_time_ms
	FROM sys.dm_os_wait_stats

END

-- Populate "action" table
INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('ASYNC_DISKPOOL_LOCK', 'Possible disk bottleneck. See the disk performance counters for confirmation.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('ASYNC_IO_COMPLETION', 'Occurs when a task is waiting for asynchronous I/Os to finish.
Identify disk bottlenecks, by using Perfmon Counters, Profiler, sys.dm_io_virtual_file_stats and SHOWPLAN.
Any of the following reduces these waits:
1.	Adding additional IO bandwidth.
2.	Balancing IO across other drives.
3.	Reducing IO with appropriate indexing. 
4.	Check for bad query plans.
5.	Check for memory pressure.  

See PERFMON Physical Disk performance counters: 
1.	Disk sec/read
2.	Disk sec/write
3.	Disk queues
See PERFMON SQLServer:Buffer Manager performance counters for memory pressure:
1.	Page Life Expectancy
2.	Checkpoint pages/sec
3.	Lazy writes/sec
See PERFMON SQLServer:Access Methods for correct indexing:
1.	Full Scans/sec
2.	Index seeks/sec
SQL Profiler can be used to identify which Transact-SQL statements do scans. Select the scans event class and events scan:started and scan:completed. Include the object Id data column. Save the profiler trace to a trace table, and then search for the scans event. The scan:completed event provides associated IO so that you can also search for high reads, writes, and duration.
Check SHOWPLAN for bad query plans')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('ASYNC_NETWORK_IO', 'Occurs on network writes when the task is blocked behind the network. Verify that the client is processing data from SQL Server.
Check network adapter bandwidth. 
1 Gigabit is better than 100 megabits.
100 megabits is better than 10 megabits.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUP', 'Occurs when a task is blocked as part of backup processing. ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUP_CLIENTLOCK', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUP_OPERATOR', 'Occurs when a task is waiting for a device mount. To view the device status, query sys.dm_io_backup_tapes. If a mount operation is not pending, this wait type can indicate a hardware problem with the device drive.
Check backup device drive.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUPBUFFER', 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a device mount.
Check backup device drive.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUPIO', 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a device mount.
Check backup device drive.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BACKUPTHREAD', 'Occurs when a task is waiting for a backup task to finish. Wait times can be long, from several minutes to several hours. If the task that is being waited on is in an I/O process, this type does not indicate a problem.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BAD_PAGE_PROCESS', 'Occurs when the background suspect page logger is trying to avoid running more than every five seconds which occurs when many suspect pages are encountered. 
Suspect pages are captured in the msdb database system table dbo.suspect_pages. 
Suspect pages can be restored using online page level restore.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BROKER_RECEIVE_WAITFOR', 'Occurs when the RECEIVE WAITFOR is waiting. This is typical if no messages are ready to be received.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('BUILTIN_HASHKEY_MUTEX', 'Can occur after instance startup when internal datastructures are initialized. Does not reoccur after datastructures have been initialized.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CHKPT', 'Occurs at server startup to tell the checkpoint thread that it can start')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_AUTO_EVENT', 'Occurs when a task is currently performing common language runtime (CLR) execution and is waiting for a particular autoevent to be initiated.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_CRST', 'Occurs when a task is currently performing CLR execution and is waiting to enter a critical section of the task that is currently being used by another task.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_JOIN', 'Occurs when a task is currently performing CLR execution and waiting for another task to end. This wait state occurs when there is a join between tasks.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_MANUAL_EVENT', 'Occurs when a task is currently performing CLR execution and is waiting for a specific manual event to be initiated.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_MONITOR', 'Occurs when a task is currently performing CLR execution and is waiting to obtain a lock on the monitor.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_RWLOCK_READER', 'Occurs when a task is currently performing CLR execution and is waiting for a reader lock.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_RWLOCK_WRITER', 'Occurs when a task is currently performing CLR execution and is waiting for a writer lock.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CLR_SEMAPHORE', 'Occurs when a task is currently performing CLR execution and is waiting for a semaphore.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CMEMTHREAD', 'Occurs when a task is waiting for a thread-safe memory object. The wait time might increase when there is contention caused by multiple tasks trying to allocate memory from the same memory object.
The serialization makes sure that as long as the users are allocating or freeing the memory from the memory object, any other server process IDs (SPIDs) that are trying to perform the same task have to wait, and the CMEMTHREAD waittype is set when the SPIDs are waiting. 
You might notice this waittype in many scenarios. However, this waittype is most frequently logged when the ad hoc query plans are being quickly inserted into a procedure cache from many different connections to the instance of SQL Server. You can address this bottleneck by limiting the data that must be inserted or removed from the procedure cache, such as explicitly parameterizing the queries so that the queries can be reused or using stored procedures where appropriate.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CURSOR', 'Asynch Cursor thread.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CURSOR_ASYNC', 'Internal only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('CXPACKET', 'Check for parallelism: sp_Configure “max degree of parallelism”. 
If max degree of parallelism = 0, you might want to use one of the following options:
1.	turn off parallelism completely for OLTP workloads: set max degree of parallelism to 1 
2.	limit parallelism by setting max degree of parallelism to some number less than the total number of CPUs. For example if you have 8 processors, set max degree of parallelism to <=4.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DBMIRROR_DBM_EVENT', 'Internal only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DBMIRROR_DBM_MUTEX', 'Internal only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DBMIRROR_SEND', 'Occurs when a task is waiting for a communications backlog at the network layer to clear to be able to send messages. Indicates that the communications layer is starting to become overloaded and affect the database mirroring data throughput.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DBMIRRORING_CMD', 'Occurs when a task is waiting for log records to be flushed to disk. This wait state is expected to be held for long periods of time.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DBTABLE', 'Internal only.
New Checkpoint request that is waiting for outstanding checkpoint request to complete
See SQL Buffer Manager performance counters:
1.	Page Life Expectancy
2.	Checkpoint pages/sec
3.	Lazy writes/sec')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DEADLOCK_ENUM_MUTEX', 'Occurs when the deadlock monitor and sys.dm_os_waiting_tasks try to make sure that SQL Server is not running multiple deadlock searches at the same time.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DEADLOCK_TASK_SEARCH', 'Large waiting time on this resource indicates that server is executing queries in addition to sys.dm_os_waiting_tasks and these queries are blocking deadlock monitor from running deadlock search (only one query or deadlock monitor can examine task state at any moment of time). DEADLOCK_TASK_SEARCH wait type is used by deadlock monitor only, queries in addition to sys.dm_os_waiting_tasks use wait type DEADLOCK_ENUM_MUTEX.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DEBUG', 'Occurs during Transact-SQL and CLR debugging for internal synchronization.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DISABLE_VERSIONING', 'Occurs when SQL Server polls the version transaction manager to see whether the timestamp of the earliest active transaction is later than the timestamp of when the state started changing. If this is this case, all the snapshot transactions that were started before the ALTER DATABASE statement was run have finished. This wait state is used when SQL Server disables versioning by using the ALTER DATABASE statement.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DISKIO_SUSPEND', 'Occurs when a task is waiting to access a file when an external backup is active. This is reported for each waiting user process. A count larger than five per user process can indicate that the external backup is taking too much time to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DROPTEMP', 'Occurs between attempts to drop a temporary object if the previous try failed. The wait duration grows exponentially with each failed drop try.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC', 'Check transaction isolation level. Occurs when a task is waiting for an event that is used to manage state transition. This state controls when the recovery of Microsoft Distributed Transaction Coordinator (MS DTC) transactions occurs after SQL Server receives notification that the MS DTC service has become unavailable. This state also describes a task that is waiting when a commit of a MS DTC transaction is initiated by SQL Server and SQL Server is waiting for the MS DTC commit to finish.
Waiting for Distributed Transaction Coordinator')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC_ABORT_REQUEST', 'Occurs in a MS DTC worker session when the session is waiting to take ownership of a MS DTC transaction. After MS DTC owns the transaction, the session can roll back the transaction. Generally, the session waits for another session that is using the transaction')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC_RESOLVE', 'Occurs when a recovery task is waiting for the master database in a cross-database transaction so that the task can query the outcome of the transaction.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC_STATE', 'Occurs when a task is waiting for an event that protects changes to the internal MS DTC global state object. The state should be held for very short periods of time.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC_TMDOWN_REQUEST', 'Occurs in a MS DTC worker session when SQL Server receives notification that the MS DTC service is not available. First the worker waits for the MS DTC recovery process to start. Then the worker waits to obtain the outcome of the distributed transaction that the worker is working on. This can continue until the connection with the MS DTC service has been reestablished.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DTC_WAITFOR_OUTCOME', 'Occurs when recovery tasks wait for MS DTC to become active to enable the resolution of prepared transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('DUMP_LOG_COORDINATOR', 'Occurs when a main task is waiting for a subtask to generate data. Ordinarily, this state does not occur. A long wait indicates an unexpected blockage. The subtask should be investigated.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('EC', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('EE_PMOLOCK', 'Occurs during synchronization of certain memory allocation during statement execution.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('ENABLE_VERSIONING', 'Occurs when SQL Server waits for all update transactions in this database to finish before declaring the database ready to transition to snapshot isolation enabled state. This state is used when SQL Server enables snapshot isolation by using the ALTER DATABASE statement.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('EXCHANGE', 'Occurs during synchronization in the query processor exchange iterator during parallel queries.
Check for parallelism: sp_Configure “max degree of parallelism”. 
If max degree of parallelism = 0, you might want to use one of the following options:
1.	turn off parallelism completely: set max degree of parallelism to 1 
2.	limit parallelism by setting max degree of parallelism to some number less than the total number of CPUs. For example if you have 8 processors, set max degree of parallelism to <=4.
')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('EXECSYNC', 'Occurs during parallel queries while synchronizing in query processor in areas not related to the exchange iterator. Examples of such area are bitmaps, large binary objects (BLOBs) and the spool iterator. LOBs can frequently use this wait state. Bitmap and spool use should not cause contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('FAILPOINT', 'Internal only. ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('FCB_REPLICA_READ', 'Occurs when the reads of a snapshot (or a temporary snapshot created by DBCC) sparse file are synchronized.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('FCB_REPLICA_WRITE', 'Occurs when the pushing or pulling of a page to a snapshot (or a temporary snapshot created by DBCC) sparse file are synchronized.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('FT_RESTART_CRAWL', 'Occurs when a full-text crawl (population) must restart from a last known good point to recover from a transient failure. The wait is for letting the worker tasks currently working on that population to complete/exit the current step.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('FT_RESUME_CRAWL', 'Occurs when throttled full-text crawls (population) pause to wait for existing activity to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('HTTP_ENDPOINT_COLLCREATE', 'Internal only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('HTTP_ENUMERATION', 'Occurs at startup to enumerate the HTTP endpoints to start HTTP.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('IMP_IMPORT_MUTEX', 'Internal only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('IMPPROV_IOWAIT', 'Occurs when SQL Server waits for a bulkload I/O to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('INDEX_USAGE_STATS_MUTEX', 'Internal only.' )

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('IO_AUDIT_MUTEX', 'Occurs during synchronization of trace event buffers.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('IO_COMPLETION', 'Occurs while waiting for I/O operations to finish. This wait type generally represents non-data page I/Os. Data page I/O completion waits appear as PAGEIOLATCH_* waits.
Identify disk bottlenecks by using Performance Counters, Profiler, sys.dm_io_virtual_file_stats and SHOWPLAN
Any of the following reduces these waits:
1.	Adding additional IO bandwidth, 
2.	Balancing IO across other drives
3.	Reducing IO with appropriate indexing
4.	Check for bad query plans

See Disk performance counters: 
1.	Disk sec/read
2.	Disk sec/write
3.	Disk queues
See SQL Buffer Manager performance counters:
1.	Page Life Expectancy
2.	Checkpoint pages/sec
3.	Lazy writes/sec
See SQL Access Methods for  correct indexing:
1.	Full Scans/sec
2.	Index seeks/sec
See memory performance counter
•	Page faults/sec
Refer to Io_stalls section to identify IO bottlenecks. 
SQL Profiler can be used to identify which Transact-SQL statements do scan. Select the scans event class and events scan:started and scan:completed. Include the object Id data column. Save the profiler trace to a trace table, and then search for the scans event. The scan:completed event provides the associated IO so that you can also search for high reads, writes, and duration.
Check SHOWPLAN for bad query plans ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('KTM_ENLISTMENT', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('KTM_RECOVERY_MANAGER', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('KTM_RECOVERY_RESOLUTION', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_DT', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_EX', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_KP', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_NL', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_SH', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LATCH_UP', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. 
“Plain” latches are generally not related to IO. These latches can be used for a variety of things, but they are not used to synchronize access to buffer pages (PAGELATCH_x is used for that). 
Possibly the most common case is contention on internal caches (not the buffer pool pages), especially when using heaps or text. 

If high, check PERFMON for 
1.	memory pressure
2.	SQL Latch waits (ms)
Look for LOG and Pagelatch_UP wait types.
Latch_x waits can frequently be reduced by solving LOG and PAGELATCH_UP contention. If there is no  LOG or PAGELATCH_UP contention, the only other option is to partition the table/index in question in order to create multiple caches (the caches are per-index). ')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LAZYWRITER_SLEEP', 'Occurs when lazy writer tasks are suspended. In a measure of the time that is spent by background tasks that are waiting. Do not consider this state when you are looking for user stalls.')

-- Due to the repeat for this guidance, setting to a variable for multiple-use
SELECT @LockMsg = 'Possible transaction management issue. 
1.	For shared locks, check Isolation level for transaction. 
2.	Keep transaction as short as possible
See SQL Locks performance counters
•	Lock wait time (ms)
Hint: check for memory pressure, which causes more physical IO, therefore prolonging the duration of transactions and locks.'

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_BU', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_IS', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_IU', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_IX', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RIn_NL', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RIn_S', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RIn_U', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RIn_X', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RS_S', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RS_U', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RX_S', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RX_U', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_RX_X', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_S', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_SCH_M', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_SCH_S', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_SIU', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_SIX', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_U', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_UIX', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LCK_M_X', @LockMsg)

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LOGBUFFER', 'Occurs when a task is waiting for space in the log buffer to store a log record. Consistently high values can indicate that the log devices cannot keep up with the logging information being generated by the server.
See Disk performance counters: 
1.	Disk sec/read
2.	Disk sec/write
3.	Disk queues')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LOGMGR', 'Occurs when a task is waiting for any outstanding log I/Os to finish before it shuts down the log. 
Identify disk bottlenecks, by using Performance Counters, Profiler,
sys.dm_io_virtual_file_stats and SHOWPLAN
Any of the following reduces these waits:
1.	Adding additional IO bandwidth, 
2.	Balancing IO across other drives
3.	Moving / Isolating the transaction log on its own drive
See Disk performance counters: 
1.	Disk sec/read
2.	Disk sec/write
3.	Disk queues
See SQL Buffer Manager performance counters:
1.	Page Life Expectancy
2.	Checkpoint pages/sec
3.	Lazy writes/sec
Check Io_stall for tranlog
•	select * from sys.dm_io_virtual_file_stats(dbid,file#)')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LOGMGR_FLUSH', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LOGMGR_RESERVE_APPEND', 'Occurs when a task is waiting to see whether log truncation frees log space to enable the task to write a new log record. Consider increasing the size of the log file(s) for the affected database to reduce this wait.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('LOWFAIL_MEMMGR_QUEUE', 'Occurs while waiting for memory to be available for use.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MIRROR_SEND_MESSAGE', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MISCELLANEOUS', 'This is a "Catch all" wait type')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSQL_DQ', 'Occurs when a task is waiting for a distributed query operation to finish. This is used to detect potential Multiple Active Result Set (MARS) application deadlocks. The wait ends when the distributed query call finishes.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSQL_SYNC_PIPE', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSQL_XACT_MGR_MUTEX', 'Occurs when a task is waiting to obtain ownership of the session transaction manager to perform a session level transaction operation')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSQL_XACT_MUTEX', 'Occurs during synchronization of usage of a transaction. A request must successfully acquire the mutex before it can use the transaction.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSQL_XP', 'Occurs when a task is waiting for an extended stored procedure to end. SQL Server uses this wait state to detect potential MARS application deadlocks. The wait stops when the extended stored procedure call ends.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('MSSEARCH', 'Occurs during Full-Text search calls. This wait ends when the full-text operation is finished. It does not indicate contention, but the duration of full-text operations.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('NET_WAITFOR_PACKET', 'Occurs when a connection is waiting for a network packet during a network read.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('OLEDB', 'Occurs when SQL Server calls the Microsoft SQL Native Client OLE DB Provider. This state is not used for synchronization, instead it indicates the duration of calls to the OLE DB provider. It can also include the following:
Linked server calls including four part name calls, remote procedure calls, openquery, openrowset and so on.
Queries that access DMVs, because these are implemented as OLE DB rowset providers.
Heavy Profiler tracing
1.	Check placement of client applications including any file input read by the client and SQL Server data and log files. See PERFMON disk secs/read and disk secs/write. If disk secs/read are high, you can add IO bandwidth, balance IO across other drives, and move or isolate the database and transaction log to its own drives 
2.	Inspect Transact-SQL code for RPC, Distributed (Linked Server) and Full Text Search. Although SQL Server supports these type queries, they are sometimes performance bottlenecks. 
3.	To retrieve the SQL statement involved in OLE DB waits, refer to section “Retrieving statements in the waiter list”.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_DT', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_EX', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_KP', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_NL', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_SH', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGEIOLATCH_UP', 'Latches are short term synchronization objects. used to synchronize access to buffer pages. PageIOLatch is used for disk to memory transfers.
If this is significant in percentage, it typically suggests disk IO subsystem issues. Check disk counters.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_DT', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_EX', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_KP', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_NL', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_SH', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PAGELATCH_UP', 'Latches are short term light weight synchronization objects. Latches are not held for the duration of a transaction. Typical latching operations during row transfers to memory, controlling modifications to row offset table, and so on. Therefore, the duration of latches is typically sensitive to available memory.
If this is significant in percentage, it typically indicates cache contention.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('PRINT_ROLLBACK_PROGRESS', 'Used to wait while user processes are ended in a database that has been transitioned by using the ALTER DATABASE termination clause. For more information, see ALTER DATABASE (Transact-SQL).')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QNMANAGER_ACQUIRE', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QPJOB_KILL', 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL as the update was starting to run. The terminating thread is suspended, waiting for it to start listening for KILL commands. A good value is less than one second.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QPJOB_WAITFOR_ABORT', 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL when it was running. The update has now completed but is suspended until the terminating thread message coordination is finished. This is an ordinary but rare state, and should be very short. A good value is less than one second.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QRY_MEM_GRANT_INFO_MUTEX', 'Occurs when Query Execution memory management tries to control access to static grant information list. This state lists information about the current granted and waiting memory requests. This state is a simple access control state. There should never be a long wait for this state. If this mutex is not released, all new memory-using queries will stop responding.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QUERY_NOTIFICATION_MGR_MUTEX', 'Occurs during synchronization of the garbage collection queue in the Query Notification Manager.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QUERY_NOTIFICATION_SUBSCRIPTION_MUTEX', 'Occurs during state synchronization for transactions in Query Notifications.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QUERY_NOTIFICATION_TABLE_MGR_MUTEX', ' Occurs during internal synchronization within the Query Notification Manager.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('QUERY_TRACEOUT', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RECOVER_CHANGEDB', 'Occurs during synchronization of database warm standby databases')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('REPL_CACHE_ACCESS', 'Occurs during synchronization on a replications article cache. During these waits the replication log reader stalls and DDL on a published table is blocked.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('REPL_SCHEMA_ACCESS', 'Occurs during synchronization on a replications article cache. During these waits the replication log reader stalls and DDL on a published table is blocked')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('REPLICA_WRITES', 'Occurs while a task waits for page writes to database snapshots or DBCC replicas to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('REQUEST_DISPENSER_PAUSE', 'Occurs when a task is waiting for all outstanding I/O to complete so that I/O to a file can be frozen for snapshot backup.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RESOURCE_QUEUE', 'Occurs during synchronization on various internal resource queues.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RESOURCE_SEMAPHORE', 'Occurs when a query memory request cannot be granted immediately because of other concurrent queries. High waits and wait times can indicate excessive number of concurrent queries or excessive memory request amount.
COMMON for DSS like workload and large queries such as hash joins; must wait for memory quota (grant) before it is executed.
See SQL Memory Mgr performance counters
1.	Memory Grants Pending
2.	Memory Grants Outstanding')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RESOURCE_SEMAPHORE_MUTEX', 'Occurs while a query waits for its request for a thread reservation to be fulfilled. It also occurs when synchronizing query compile and memory grant requests')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RESOURCE_SEMAPHORE_QUERY_COMPILE', 'Occurs when the number of concurrent query compiles hit a throttling limit in order to avoid over-burdening the system with compiles. High waits and wait times can indicate of excessive compilations, recompiles or uncachable plans.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('RESOURCE_SEMAPHORE_SMALL_QUERY', 'Occurs when memory request by small query cannot be granted immediately because of other concurrent queries. Wait time should not exceed several seconds because the server transfers the request to the mainquery memory pool if it cannot grant the requested memory within a few seconds. High waits can indicate too many concurrent small queries when the main memory pool is blocked by waiting queries.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SEC_DROP_TEMP_KEY', 'Occurs after failed attempt to drop a temporary security key before a retry attempt.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SERVER_IDLE_CHECK', 'Occurs during synchronization of an instance of SQL Server idle status when a resource monitor is trying to declare an instance of SQL Server as idle or trying wake it up.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SLEEP_BPOOL_FLUSH', 'Occurs during checkpoints when checkpoint is throttling the issuing of new I/Os in order to avoid flooding the disk subsystem.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SLEEP_SYSTEMTASK', 'Occurs during start of background task while waiting for tempdb to complete startup.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SLEEP_TASK', 'Occurs when a task sleeps while waiting for a generic event to occur.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SNI_HTTP_ACCEPT', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SNI_HTTP_WAITFOR_0_DISCON', 'Occurs during SQL Server shutdown while waiting for outstanding http connections to exit.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOAP_READ', 'Occurs when waiting for an HTTP network read to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOAP_WRITE', 'Occurs when waiting for an HTTP network write to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_CALLBACK_REMOVAL', 'Occurs when synchronization on a callback list in order to remove a callback. It is not expected for this counter to change after server initialization is completed')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_LOCALALLOCATORLIST', 'Occurs during internal synchronization in the SQL Server memory manager.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_OBJECT_STORE_DESTROY_MUTEX', 'Occurs during internal synchronization in memory pools when destroying objects from the pool')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_PROCESS_AFFINITY_MUTEX', 'Occurs during synchronizing of access to process affinity settings')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_RESERVEDMEMBLOCKLIST', 'Occurs during internal synchronization in the SQL Server memory manager.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_SCHEDULER_YIELD', 'Occurs when a task voluntarily yields the scheduler for other tasks to execute. During this wait the task is waiting for its quantum to be renewed.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_STACKSTORE_INIT_MUTEX', 'Occurs during synchronization of internal store initialization.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_SYNC_TASK_ENQUEUE_EVENT', 'Occurs when a task is started in a synchronous manner. Most tasks in SQL Server 2005 are started in an asynchronous manner and control returns to the starter immediately after the task request has been put on the work queue.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOS_VIRTUALMEMORY_LOW', 'Occurs when a memory allocation waits for a resource manager to free virtual memory.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_EVENT', 'Occurs when a hosted component, such as CLR, waits for a SQL Server 2005 event synchronization object.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_INTERNAL', 'Occurs during synchronization of memory manager callbacks used by hosted components, such as CLR.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_MUTEX', 'Occurs when a hosted component, such as CLR, waits for a SQL Server 2005 mutex synchronization')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_RWLOCK', 'Occurs when a hosted component, such as CLR, waits for a SQL Server 2005 reader-writer synchronization')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_SEMAPHORE', 'Occurs when a hosted component, such as CLR, waits for a SQL Server 2005 semaphore synchronization object')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_SLEEP', 'Occurs when a hosted task sleeps when waiting for a generic event to occur Hosted tasks are used by hosted components such as CLR.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_TRACELOCK', 'Occurs during synchronization of access to trace streams.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SOSHOST_WAITFORDONE', 'Occurs when a hosted component, such as CLR, waits for a task to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLCLR_APPDOMAIN', 'Occurs while CLR waits for an application domain to complete startup')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLCLR_ASSEMBLY', 'Occurs while waiting for access to the loaded assembly list in the sql appdomain')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLCLR_DEADLOCK_DETECTION', 'Occurs while CLR waits for deadlock detection to finish.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLCLR_QUANTUM_PUNISHMENT', 'Occurs when a CLR task is throttled because it has exceeded its execution quantum. This throttling is done in order to reduce the effect of this greedy task on other tasks.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLSORT_NORMMUTEX', 'Occurs during internal synchronization when initializing internal sorting structures.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLSORT_SORTMUTEX', 'Occurs during internal synchronization when initializing internal sorting structures.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLTRACE_BUFFER_FLUSH', 'Occurs when the SQL Trace flush task pauses between flushes. This wait is expected and long waits do not indicate a problem')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLTRACE_LOCK', 'Occurs during synchronization on trace buffers during a file trace.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLTRACE_SHUTDOWN', 'Occurs when a trace shutdown waits for outstanding trace events to finish')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SQLTRACE_WAIT_ENTRIES', 'Occurs when a SQL Trace event queue waits for packets to arrive on the queue.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('SRVPROC_SHUTDOWN', 'Occurs when the shutdown process waits for internal resources to be released to shutdown cleanly.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TEMPOBJ', 'Occurs when temporary object drops are synchronized. This wait is rare and only occurs if a task has requested exclusive access for temp table drops.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('THREADPOOL', 'Occurs when a task is waiting for a worker to run on. This can indicate that the max worker setting is too low or that batch executions are taking unusually long therefore reducing the number of worker available to satisfy other batches.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_DT', 'Occurs when waiting for a destroy mode latch on a transaction mark latch. Transaction mark latches are used for synchronization of commits with marked transactions. Marked transaction enable restore to specific marked transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_EX', 'Occurs when waiting for an exclusive mode latch on a transaction mark latch. Transaction mark latches are used for synchronization of commits with marked transactions. Marked transaction enable restore to specific marked transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_KP', 'Occurs when waiting for a keep mode latch on a transaction mark latch. Transaction mark latches are used for synchronization of commits with marked transactions. Marked transactions enable restore to specific marked transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_NL', 'Internal Only.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_SH', 'Occurs when waiting for a share mode latch on a transaction mark latch. Transaction mark latches are used for synchronization of commits with marked transactions. Marked transactions enable restore to specific marked transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRAN_MARKLATCH_UP', 'Occurs when waiting for an update mode latch on a transaction mark latch. Transaction mark latches are used for synchronization of commits with marked transactions. Marked transactions enable restore to specific marked transactions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('TRANSACTION_MUTEX', 'Occurs during synchronization of access to a transaction by multiple batches.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('UTIL_PAGE_ALLOC', 'Occurs when transaction log scans wait for memory to be available during memory pressure.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('VIEW_DEFINITION_MUTEX', 'Occurs during synchronization on access to cached view definitions.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('WAIT_FOR_RESULTS', 'Occurs when waiting for a query notification to be triggered.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('WAITFOR', 'Occurs because of a WaitFor Transact-SQL statement. The duration of the wait is determined by the parameters to the statement. This is a user initiated wait.
Inspect Transact-SQL code for “waitfor delay” statement')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('WORKTBL_DROP', 'Occurs when pausing before retrying after a failed worktable drop.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('WRITELOG', 'Occurs when waiting for a log flush to finish. Common operations that cause log flushes are checkpoints and transaction commits. 
Identify disk bottlenecks, by using Performance Counters, Profiler, sys.dm_io_virtual_file_stats and SHOWPLAN
Any of the following reduces these waits:
1.	Adding additional IO bandwidth, 
2.	Balancing IO across other drives
3.	Moving or Isolating the transaction log on its own drive
See Disk performance counters: 
1.	Disk sec/read
2.	Disk sec/write
3.	Disk queues
See SQL Buffer Manager counters:
1.	Page Life Expectancy
2.	Checkpoint pages/sec
3.	Lazy writes/sec
Check Io_stall for tranlog
•	select * from sys.dm_io_virtual_file_stats(dbid,file#)
')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('XACT_OWN_TRANSACTION', 'Occurs when waiting to acquire ownership of a transaction.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('XACT_RECLAIM_SESSION', 'Occurs when waiting for the current owner of a session to release ownership of the session.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('XACTLOCKINFO', 'Occurs during synchronization of access to a transactions list of locks. In addition to the transaction itself, a transactions list of locks is accessed by operations such as deadlock detection and lock migration during page splits.')

INSERT @wait_type_action (wait_type, next_step_desc) 
VALUES ('XACTWORKSPACE_MUTEX', 'Occurs during synchronization of defections from a transactions in addition to the transfer of database locks between enlist members of a transaction.')

IF @DeltaMinutes IS NOT NULL
BEGIN

	-- Calculate Total Accumulated Wait Time for use in next query
	SELECT @sum_wait_time_ms = SUM(d.wait_time_ms - o.wait_time_ms)
	FROM @dm_os_wait_stats_original o
	INNER JOIN @dm_os_wait_stats_delta d ON
		o.wait_type = d.wait_type
	
	-- Show high percentage wait time accumulated between start/end time
	SELECT  TOP (@TopN)
			o.wait_type,
			((cast(d.wait_time_ms as numeric) - cast(o.wait_time_ms as numeric))
				/cast(@sum_wait_time_ms as numeric)) * 100 wait_time_percentage,
			ISNULL(a.next_step_desc, 'No action.') next_step_desc
	FROM @dm_os_wait_stats_original o
	INNER JOIN @dm_os_wait_stats_delta d ON
		o.wait_type = d.wait_type
	LEFT OUTER JOIN @wait_type_action a ON
		o.wait_type = a.wait_type
	ORDER BY 
	((cast(d.wait_time_ms as numeric) - cast(o.wait_time_ms as numeric))
				/cast(@sum_wait_time_ms as numeric)) * 100 DESC			
END
ELSE
IF @DeltaMinutes IS NULL
BEGIN

	-- Calculate Total Accumulated Wait Time for use in next query
	SELECT @sum_wait_time_ms = SUM(o.wait_time_ms)
	FROM @dm_os_wait_stats_original o
		
	-- Show top wait type percentage
	SELECT TOP (@TopN)
			o.wait_type,
			(cast(o.wait_time_ms as numeric)
				/cast(@sum_wait_time_ms as numeric)) * 100 delta_wait_time_percentage,
			ISNULL(a.next_step_desc, 'No action.') next_step_desc
	FROM @dm_os_wait_stats_original o
	LEFT OUTER JOIN @wait_type_action a ON
		o.wait_type = a.wait_type
	ORDER BY 
	(cast(o.wait_time_ms as numeric)
				/cast(@sum_wait_time_ms as numeric)) * 100 DESC			
END

END TRY
BEGIN CATCH
	SELECT	ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_MESSAGE()
END CATCH


