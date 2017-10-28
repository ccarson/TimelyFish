/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS( SELECT 1 FROM dbo.CFT_EVENTTYPE ) 
BEGIN
	INSERT INTO
		dbo.CFT_EVENTTYPE( 
			 ID
           , CREATE_DATE
           , LAST_UPDATE
           , CREATED_BY
           , LAST_UPDATED_BY
           , DELETED_BY
           , EVENTNAME
           , EVENTTYPE
           , REASONID
           , STATUS )
	SELECT 
		ID
      , CREATE_DATE
      , LAST_UPDATE
      , CREATED_BY
      , LAST_UPDATED_BY
      , DELETED_BY
      , EVENTNAME
      , EVENTTYPE
      , REASONID
      , STATUS 
	FROM 
		[$(MobileFrameServer)].[$(MobileFrame)].dbo.CFT_EVENTTYPE ;
END


IF NOT EXISTS( SELECT 1 FROM stage.CFT_EVENTTYPE ) 
BEGIN
	INSERT INTO
		stage.CFT_EVENTTYPE( 
			 ID
           , CREATE_DATE
           , LAST_UPDATE
           , CREATED_BY
           , LAST_UPDATED_BY
           , DELETED_BY
           , EVENTNAME
           , EVENTTYPE
           , REASONID
           , STATUS )
	SELECT 
		ID
      , CREATE_DATE
      , LAST_UPDATE
      , CREATED_BY
      , LAST_UPDATED_BY
      , DELETED_BY
      , EVENTNAME
      , EVENTTYPE
      , REASONID
      , STATUS 
	FROM 
		[$(MobileFrameServer)].[$(MobileFrame)].dbo.CFT_EVENTTYPE ;
END



IF NOT EXISTS( SELECT 1 FROM dbo.MobileFrameFarms ) 
BEGIN
	INSERT INTO
		dbo.MobileFrameFarms( site_id, FarmName, ExecuteInitialLoad )
	VALUES( 3, 'C10', 0x0 ) ; 
END


IF NOT EXISTS( SELECT 1 FROM dbo.LookupCodes ) 
BEGIN
	SET IDENTITY_INSERT dbo.LookupCodes ON ; 

	INSERT INTO dbo.LookupCodes( LookupCodesKey, LookupType, LookupCodesDescription, PigChampValue, MobileFrameReasonID, MobileFrameValue )
	VALUES (01, N'Removal Reason',  N'Unspecified',             N'****',    0,      N'67DB0900-500E-492F-847A-C103D2C0E448')
         , (02, N'Removal Reason',  N'After 2nd Time Repeat',   N'1005',    1,      N'949BB9D4-215D-4315-A5AF-F06477E16F9E')
         , (03, N'Removal Reason',  N'Wfi More Than 30 Days',   N'1009',    2,      N'6600A454-DC27-4E3A-B00B-EE43F09CB3AA')
         , (04, N'Removal Reason',  N'Gilt-no Cycle',           N'1013',    3,      N'034B26CD-973A-4B44-86F0-73DA4C6FD549')
         , (05, N'Removal Reason',  N'Heavy Discharge',         N'1011',    4,      N'EAE280E6-C8B5-4B4A-A669-435EF67E15EB')
         , (06, N'Removal Reason',  N'Farrowing Complication',  N'23',      5,      N'924FF5C2-1D53-41F4-8383-4E021871D365')
         , (07, N'Removal Reason',  N'Less Than 2 Bcs',         N'1014',    6,      N'9747A09D-C017-4673-93E3-5F8CE8B83486')
         , (08, N'Removal Reason',  N'Structural Soundness',    N'1002',    7,      N'89D73AD2-3B55-4F42-8F08-3B697C47CC86')
         , (09, N'Removal Reason',  N'Prolapse',                N'56',      8,      N'F55BF028-F18A-464E-AA7C-B0A551837253')
         , (10, N'Removal Reason',  N'Injury - Leg, Body',      N'1003',    9,      N'34DE1CAC-1446-433C-8F2F-4248FA7ED519')
         , (11, N'Removal Reason',  N'Depopulation',            N'16',      10,     N'FDFD6734-76B4-4000-B61F-09230DA6D57F')
         , (12, N'Removal Reason',  N'Gastrointestinal',        N'1004',    11,     N'ED135E83-FEDD-4EE3-8165-0F70AAA26071')
         , (13, N'Removal Reason',  N'Respiratory',             N'59',      12,     N'548C0F3F-106E-4AB6-9764-ADB78ABC9046')
         , (14, N'Removal Reason',  N'Parity',                  N'1001',    13,     N'D8B0E002-C0FE-4EA8-B766-8CE586DF5F36')
         , (15, N'Removal Reason',  N'Poor Underline',          N'1008',    14,     N'9E9A8702-DD4C-43D9-AC7D-11F76B18273C')
         , (16, N'Removal Reason',  N'Low Lifetime Ba',         N'1007',    15,     N'7E7A95D9-A005-4E01-9BFB-D0910FC23D71')
         , (17, N'Removal Reason',  N'Poor Milker',             N'54',      16,     N'5B3E1031-D523-4C5C-8063-A2FB9C5C7C3C')
         , (18, N'Removal Type',    N'Transfer',                N'',        NULL,   N'A1B76076-9C74-4F76-81FE-8A700D121CA5')
         , (19, N'Breed Reason',    N'Abortion',                N'****',    NULL,   N'98A08D4C-8346-458E-A8B2-7F65BC8E3906')
         , (20, N'Removal Type',    N'Cull',                    N'****',    NULL,   N'0DF1E4D5-0023-4E35-9C1D-F661B3222649')
         , (21, N'Removal Type',    N'Death',                   N'****',    NULL,   N'5BED6F3E-EAA6-4FDA-97A4-FA4349F3BF86')
         , (22, N'Removal Type',    N'Euth',                    N'****',    NULL,   N'4844F134-E0E7-4254-B02F-AFDB28CA35ED')
         , (23, N'Removal Reason',  N'Not on inventory',        N'1006',    17,     N'21E957C7-28B9-4859-980C-77C7CB99742A') 
         , (24, N'Wean Type',		N'WEAN',					N'265',		NULL,   N'DD1C4685-D867-4CAE-96B7-0CCBCD237F50') 
         , (25, N'Wean Type',		N'PART WEAN',				N'220',		NULL,   N'B6FE41B2-28D3-48CD-B922-18B173657589') 
		 , (26, N'Wean Type',		N'WEAN',					N'260',		NULL,   N'DD1C4685-D867-4CAE-96B7-0CCBCD237F50') ;
	
	SET IDENTITY_INSERT dbo.LookupCodes OFF ;
END

IF NOT EXISTS( SELECT 1 FROM dimension.Farm WHERE FarmKey = -1 ) 
BEGIN 
    SET IDENTITY_INSERT dimension.Farm ON ; 
    INSERT INTO 
        dimension.Farm( 
            FarmKey
          , IsActive
          , FarmNumber
          , FarmName
          , TattooLength
          , FarmGUID
          , MainSiteID
          , CreatedDate
          , CreatedBy
		  , SourceGUID	
          , SourceID )
    SELECT 
            FarmKey         =   -1
          , IsActive        =   0
          , FarmNumber      =   N''
          , FarmName        =   N'Unknown'
          , TattooLength    =   0 
          , FarmGUID        =   NEWID()
          , MainSiteID      =   -1
          , CreatedDate     =   GETUTCDATE()
          , CreatedBy       =   -1
		  , SourceGUID		=	CAST( CONVERT( uniqueidentifier, 0x0 ) AS nvarchar(36) )
          , SourceID        =   -1 ; 

    SET IDENTITY_INSERT dimension.Farm OFF ; 
END 


IF NOT EXISTS( SELECT 1 FROM dimension.Origin WHERE OriginKey = -1 ) 
BEGIN 
    SET IDENTITY_INSERT dimension.Origin ON ; 
    INSERT INTO 
        dimension.Origin( 
            OriginKey
          , FarmKey
		  , OriginName
          , CreatedDate
          , CreatedBy
		  , SourceGUID
          , SourceID )
    SELECT 
            OriginKey       =   -1
          , FarmKey         =   -1
		  , OriginName		=	N'Unknown'
          , CreatedDate     =   GETUTCDATE()
          , CreatedBy       =   -1
		  , SourceGUID		=	CAST( CONVERT( uniqueidentifier, 0x0 ) AS nvarchar(36) )
          , SourceID        =   -1 ; 
    SET IDENTITY_INSERT dimension.Origin OFF ; 
END 

IF NOT EXISTS( SELECT 1 FROM dimension.Genetics WHERE GeneticsKey = -1 ) 
BEGIN 
    SET IDENTITY_INSERT dimension.Genetics ON ; 
    INSERT INTO 
        dimension.Genetics( 
            GeneticsKey
          , GeneticsName
          , Sex
          , IsDisabled
          , IsSystem
          , GeneticsSynonym
          , CreatedDate
          , CreatedBy
		  , SourceGUID
          , SourceID )
    SELECT 
            GeneticsKey         =   -1
          , GeneticsName        =   N'Unknown'
          , Sex                 =   N''
          , IsDisabled          =   1
          , IsSystem            =   1
          , GeneticsSynonym     =   N''
          , CreatedDate         =   GETUTCDATE()
          , CreatedBy           =   -1
		  , SourceGUID			=	CAST( CONVERT( uniqueidentifier, 0x0 ) AS nvarchar(36) ) 
          , SourceID            =   -1 ; 

    SET IDENTITY_INSERT dimension.Genetics OFF ; 
END 

IF NOT EXISTS( SELECT 1 FROM dimension.Date )
BEGIN
    DECLARE 
        @StartDate  datetime    =   '1970-01-01'
      , @EndDate    datetime    =   '2030-01-01' ;

    WITH numbers AS(
        SELECT 
            N = ROW_NUMBER() OVER( ORDER BY ( SELECT NULL ) )
        FROM 
            sys.sysobjects a , sys.sysobjects b ) 
    INSERT INTO 
        dimension.Date( 
            DateKey
          , FullDate ) 
    SELECT 
        DateKey     = CAST( CONVERT( varchar(08), DATEADD( day, N - 1, @StartDate ), 112 ) AS INT )
      , FullDate    = DATEADD( day, N - 1, @StartDate ) 
    FROM 
        numbers
    WHERE 
        DATEADD( day, N - 1, @StartDate ) < @EndDate ; 
END

IF NOT EXISTS( SELECT 1 FROM stage.LastChangeTrackingVersion )
BEGIN
    INSERT INTO 
        stage.LastChangeTrackingVersion( 
			DatabaseName					
          , LastChangeTrackingVersion		
		  , LastChangeAppliedDate ) 
    VALUES
		( N'PigCHAMP', 0, '1970-01-01' ) 
	  , ( N'CFDataStore', 0, '1970-01-01' ) ; 

END

IF NOT EXISTS( SELECT 1 FROM dimension.Observer WHERE ObserverKey = -1 ) 
BEGIN 
    SET IDENTITY_INSERT dimension.Observer ON ; 
    INSERT INTO 
        dimension.Observer( 
            ObserverKey
		  , FarmKey
          , ObserverName
          , IsDisabled
          , ObserverSynonym
          , CreatedDate
          , CreatedBy
		  , SourceCode
		  , SourceGUID
          , SourceID )
    SELECT 
            GeneticsKey         =   -1
		  , FarmKey         =   -1
          , GeneticsName        =   N'Unknown'
          , IsDisabled          =   1
          , ObserverSynonym    =   N''
          , CreatedDate         =   GETUTCDATE()
          , CreatedBy           =   -1
		  , SourceCode			= N''
		  , SourceGUID			=	CAST( CONVERT( uniqueidentifier, 0x0 ) AS nvarchar(36) ) 
          , SourceID            =   -1 ; 

    SET IDENTITY_INSERT dimension.Observer OFF ; 
END 

