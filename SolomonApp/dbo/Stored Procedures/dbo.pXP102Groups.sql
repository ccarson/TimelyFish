
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.pXP102Groups    Script Date: 5/6/2005 9:56:18 AM ******/

/****** Object:  Stored Procedure dbo.pXF102Bins    Script Date: 5/5/2005 4:11:20 PM ******/



CREATE          Proc dbo.pXP102Groups
		@Contact varchar(6),
		@Group varchar(10)


as
select  pg.PigGroupID 
	FROM cftPigGroup pg
	Where pg.PGStatusID IN ('F','A','T') 
	AND pg.SiteContactID=@Contact
	AND pg.PigGroupID Like @Group



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP102Groups] TO [MSDSL]
    AS [dbo];

