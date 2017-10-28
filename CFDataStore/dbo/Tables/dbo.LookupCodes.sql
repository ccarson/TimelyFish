CREATE TABLE 
	dbo.LookupCodes (
		LookupCodesKey			int				not null  IDENTITY PRIMARY KEY CLUSTERED
      , LookupType				nvarchar(50)	not null	
	  , LookupCodesDescription  nvarchar(50)	not null
	  , PigChampValue			nvarchar(50)	not null
	  , MobileFrameReasonID		int
	  , MobileFrameValue		nvarchar(50) 	not null ) ; 




