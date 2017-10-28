CREATE TABLE 
	dbo.MobileFrameFarms(
		site_id					int				NOT NULL	PRIMARY KEY CLUSTERED
      , FarmName				nvarchar(50)	NOT NULL
	  , ExecuteInitialLoad		bit				NOT NULL ) ; 
