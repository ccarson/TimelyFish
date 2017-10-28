

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.pXF101FarmOrderApp    Script Date: 6/30/2005 11:04:47 AM ******/

/****** Object:  Stored Procedure dbo.pXF101FarmOrderApp    Script Date: 6/30/2005 8:26:36 AM ******/

/********************* REVISIONS **********************
Date       User        Ref     Description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
12/13/06   mdawson     Bug16   Changed OrderBy Clause to DateRequested and ContactName first

****************** END REVISIONS *********************/

CREATE      Procedure dbo.pXF101FarmOrderApp
	@parmdate datetime,
	@parm1min varchar(10)

As
Select *
From cftFeedOrder as A
JOIN cftContact B on A.ContactID=B.ContactID
LEFT JOIN cftPigGroup C on A.PigGroupID=C.PigGroupID
Where A.Status='P' AND A.DateReq <= @parmdate AND A.OrdNbr Like @parm1min 
Order By A.DateReq, B.ContactName, A.ContactID, A.BarnNbr, A.BinNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF101FarmOrderApp] TO [MSDSL]
    AS [dbo];

