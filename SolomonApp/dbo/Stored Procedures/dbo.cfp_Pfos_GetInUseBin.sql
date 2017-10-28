
  
CREATE PROCEDURE 
	[dbo].[cfp_Pfos_GetInUseBin]( 
		@p_PfosEvent		AS nvarchar(4000)	
	  , @p_SiteContactID 	AS nvarchar(4000)	
      , @p_BarnNbr 			AS nvarchar(4000)	
      , @p_RoomNbr 			AS nvarchar(4000)	
      , @p_EventDate 		AS datetime2(7)		
      , @p_PigGroupID 		AS nvarchar(4000) )	
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_SLWSAPP_GetInUseBin
     Author:    Chris Carson
    Purpose:    Replace linq-to-sql query in SLWSAPP 
		
				Currently Entity Framework calls this code with Unicode parameters 
					This causes inefficient query processing
					This proc maps Unicode parameters to local non-Unicode variables
					
    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-02-10 			Created original query 


    Notes:
		

************************************************************************************************************************************
*/	
 
SET NOCOUNT, XACT_ABORT ON ; 

/*	Load local variables with procedure parameters	*/
DECLARE 
	@l_PfosEvent		AS varchar(4000)	=	@p_PfosEvent		
  , @l_SiteContactID 	AS varchar(4000)	=	@p_SiteContactID 	
  , @l_BarnNbr 			AS varchar(4000)	=	@p_BarnNbr 			
  , @l_RoomNbr 			AS varchar(4000)	=	@p_RoomNbr 			
  , @l_EventDate 		AS datetime2(7)		=	@p_EventDate 		
  , @l_PigGroupID 		AS varchar(4000)	=	@p_PigGroupID ;

/*	Execute LINQ-to-SQL Query using local parameters	*/
WITH 
	pigGroups AS( 
	SELECT DISTINCT
		binGroup.PigGroup
      , binGroup.RoomNbr
	FROM
		dbo.cftPfosBinTrack AS pfosBinTrack
	INNER JOIN
		dbo.cftPfosEvent AS pfosEvent 
			ON pfosEvent.IDPfosEvent = pfosBinTrack.PfosEventID
	INNER JOIN	
		dbo.cfvBinGroup AS binGroup
			ON binGroup.PigGroup = pfosBinTrack.PigGroupID
				AND binGroup.BinNbr = pfosBinTrack.BinNbr
	WHERE
		LTRIM( RTRIM( pfosEvent.PfosEvent ) ) 	=   @l_PfosEvent
			AND binGroup.ContactID          	=   @l_SiteContactID
            AND binGroup.BarnNbr            	=   @l_BarnNbr
            AND binGroup.RoomNbr            	=   @l_RoomNbr
            AND pfosBinTrack.Event_DT           <=  @l_EventDate
            AND pfosBinTrack.PigGroupID         =   @l_PigGroupID  )
			
SELECT TOP 1 
	pfosBinTrack.BinNbr
  , pfosBinTrack.Crtd_DateTime
  , pfosBinTrack.Crtd_Prog
  , pfosBinTrack.Crtd_User
  , pfosBinTrack.Event_DT
  , pfosBinTrack.IDPfosBinTrack
  , pfosBinTrack.Note
  , pfosBinTrack.PfosEventID
  , pfosBinTrack.PigGroupID
  , pfosBinTrack.Tons
  , pfosBinTrack.tstamp
FROM
	dbo.cftPfosBinTrack AS pfosBinTrack
INNER JOIN
	dbo.cftPfosEvent AS pfosEvent 
		ON pfosEvent.IDPfosEvent = pfosBinTrack.PfosEventID
INNER JOIN	
	dbo.cfvBinGroup AS binGroup
		ON binGroup.PigGroup = pfosBinTrack.PigGroupID
			AND binGroup.BinNbr = pfosBinTrack.BinNbr
INNER JOIN 
    pigGroups 
        ON pigGroups.PigGroup       =   binGroup.PigGroup
            AND pigGroups.RoomNbr 	= 	binGroup.RoomNbr 
WHERE 
	LTRIM( RTRIM( pfosEvent.PfosEvent ) )	=   @l_PfosEvent
		AND binGroup.ContactID          	=   @l_SiteContactID
           AND binGroup.BarnNbr            	=   @l_BarnNbr
           AND binGroup.RoomNbr            	=   @l_RoomNbr
           AND pfosBinTrack.Event_DT	   <=   @l_EventDate
           AND pfosBinTrack.PigGroupID      =   @l_PigGroupID  

ORDER BY pfosBinTrack.Event_DT DESC , pfosBinTrack.Crtd_DateTime ASC ; 	


