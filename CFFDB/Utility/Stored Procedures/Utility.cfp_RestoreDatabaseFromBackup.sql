

CREATE PROCEDURE 
	[Utility].[cfp_RestoreDatabaseFromBackup]( 
		@BackupFileName nvarchar(max)
	  , @TargetDatabase sysname
	  , @FileNumber		INT = 1
	  ) 
AS
/*
************************************************************************************************************************************

  Procedure:    Utility.cfp_RestoreDatabaseFromBackup
     Author:    Chris Carson
    Purpose:    Restore database from backup file

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-05-18          created

    Logic Summary:


    Notes:

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

DECLARE
	@SQLCommand			nvarchar(max) 
  , @BackupFile 		nvarchar(max)
  , @MDFLogicalName		sysname
  , @LDFLogicalName 	sysname 
  , @DataDirectory		nvarchar(max)
  , @LogDirectory		nvarchar(max) 
  , @DataFileName		nvarchar(max) 
  , @LogFileName		nvarchar(max) ; 
  
  
DECLARE 
	@FileList AS TABLE(
		LogicalName 			nvarchar(128) 		
	  , PhysicalName 			nvarchar(260) 		
	  , Type 					char(1) 			
	  , FileGroupName 			nvarchar(120) 		
	  , Size 					numeric(20, 0)		
	  , MaxSize 				numeric(20, 0)		
	  , FileID 					bigint 				
	  , CreateLSN 				numeric(25,0) 		
	  , DropLSN 				numeric(25,0) 		
	  , UniqueID 				uniqueidentifier	
	  , ReadOnlyLSN 			numeric(25,0) 		
	  , ReadWriteLSN 			numeric(25,0) 		
	  , BackupSizeInBytes 		bigint 				
	  , SourceBlockSize 		int 				
	  , FileGroupID 			int 				
	  , LogGroupGUID 			uniqueidentifier 	
	  , DifferentialBaseLSN 	numeric(25,0)		
	  , DifferentialBaseGUID 	uniqueidentifier 	
	  , IsReadOnly 				bit 				
	  , IsPresent 				bit 				
	  , TDEThumbprint 			varbinary(32) ) ;
	  

/*  1)  SELECT FileList from RESTORE FILELISTONLY command against backup device */ 
SELECT	
	@SQLCommand = N'RESTORE FILELISTONLY FROM DISK=N''' 
					+ @BackupFileName + ''' WITH FILE = ' 
					+ CAST( @FileNumber AS NVARCHAR(20) ) + ' ;' ; 
					
INSERT INTO @FileList EXEC( @SQLCommand ) ;


/*  2)  SELECT logical file names from @FileList */ 
SELECT @MDFLogicalName = LogicalName FROM @FileList WHERE Type = 'D' AND FileID = 1 ; 
SELECT @LDFLogicalName = LogicalName FROM @FileList WHERE Type = 'L' AND FileID = 2 ; 

/*	
	does this proc need to be extended for databases with multiple log files or secondary physical files 
	Option:  Build MOVE commands list dynamically for each file in list? 
*/ 


/*  3)  SELECT data locations from Server properties and FileList  */ 
SELECT	
	@DataDirectory 	= CAST( SERVERPROPERTY( 'InstanceDefaultDataPath' ) AS nvarchar(max) )
  , @LogDirectory	= CAST( SERVERPROPERTY( 'InstanceDefaultLogPath' ) AS nvarchar(max) ) ;
  
SELECT
	@DataFileName	= @DataDirectory + N'/' + @TargetDatabase + '.mdf' 
  , @LogFileName	= @LogDirectory + N'/' + @TargetDatabase + '_1.ldf' 
	

  
/*  4)  EXECUTE restore command */ 
IF EXISTS( SELECT 1 FROM master.sys.databases WHERE name = @TargetDatabase )
BEGIN
	SELECT	@SQLCommand = N'ALTER DATABASE ' + QUOTENAME( @TargetDatabase ) + N' SET SINGLE_USER WITH ROLLBACK IMMEDIATE ;' ;
	PRINT 	@SQLCommand ;
	EXEC  (	@SQLCommand ) ;
END 

RESTORE DATABASE @TargetDatabase
	FROM DISK = @BackupFileName WITH  FILE = @FileNumber,  
	MOVE @MDFLogicalName TO @DataFileName,  
	MOVE @LDFLogicalName TO @LogFileName,  
	NOUNLOAD,  REPLACE,  STATS = 5 ;

SELECT 	@SQLCommand = N'ALTER DATABASE ' + QUOTENAME( @TargetDatabase ) + N' SET MULTI_USER ;' ;
PRINT 	@SQLCommand ;
EXEC  ( @SQLCommand ) ;


SELECT 	@SQLCommand = N'ALTER AUTHORIZATION ON DATABASE::' + @TargetDatabase + N' TO sa ; ' ;
PRINT 	@SQLCommand ;
EXEC  ( @SQLCommand ) ;



SELECT 	@SQLCommand = N'Database ' + @TargetDatabase + N' Restored Successfully ;' ;
PRINT 	@SQLCommand ;
	
RETURN 0 ;


