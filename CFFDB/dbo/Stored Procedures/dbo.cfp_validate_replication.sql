
CREATE PROCEDURE [dbo].[cfp_validate_replication]( @DebugPrint int = 0 ) 
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_validate_replication
     Author:    Chris Carson
    Purpose:    Executes replication validation for all publications on server

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-04-07          created

	Source:
		http://sqlblog.com/blogs/maria_zakourdaev/archive/2012/03/06/transactional-replication-are-you-sure-your-data-is-totally-synchronized.aspx

    Notes:
		Executes the system replication proc sp_publication_validation 
		Writes results to table distribution.sys.MSdistribution_history on the distributor
		Create a linked server on your publication server to the distributor.
			** At CFF, the linked server DISTRIBUTOR is actually a loopback to the publishing database
		
		View results using the following queries:
		To view all results
		
		USE distributor
		GO
		
		SELECT      
			time              
		  , PublisherServer		= s.Name            
		  , Publication			= a.publication     
		  , SubscriberServer	= s2.name
		  , TableName 			= SUBSTRING( comments, 8, CHARINDEX( '''', comments, 8 ) -8 )
		  , comments 
		FROM 
			dbo.MSdistribution_history AS h
		INNER JOIN 
			dbo.MSdistribution_agents AS a ON h.agent_id = a.id
		INNER JOIN 
			master.sys.servers AS s ON a.publisher_id = s.server_id
		INNER JOIN 
			master.sys.servers AS s2 ON a.subscriber_id = s2.server_id        
		WHERE 
			comments like 'Table %'
		; 
		
		To view only the errors: 
		EXEC master..xp_readerrorlog 0,1,'failed data validation'
		
************************************************************************************************************************************
*/
DECLARE @SQLCommand varchar(max) = N'' ;
     
SELECT 
	@SQLCommand	= @SQLCommand + N'
					EXECUTE ' + QUOTENAME( publisher_db ) + '.dbo.sp_publication_validation 
						@publication = ''' + publication + '''
					  , @rowcount_only = 2
					  , @full_or_fast =  2 
					 ; ' + CHAR(10) + CHAR(13) + '
					 WAITFOR DELAY ''00:01:00'' ;' + CHAR(10) + CHAR(13)
FROM 
	DISTRIBUTOR.distribution.dbo.MSpublications AS p
INNER JOIN
	DISTRIBUTOR.master.sys.servers AS s ON p.publisher_id = s.server_id 
WHERE 
	s.name =  @@SERVERNAME 
; 

IF 	@DebugPrint = 1 
	PRINT	@SQLCommand ;

--EXEC( @SQLCommand ) ; 

