
/****** Object:  Stored Procedure dbo.pCF510cftPigGroupOpen    Script Date: 8/20/2005 9:51:45 AM ******/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.pCF510cftPigGroupOpen    Script Date: 1/25/2005 3:34:00 PM ******/

/****** Object:  Stored Procedure dbo.pCF510cftPigGroupOpen    Script Date: 11/2/2004 1:27:46 PM ******/

/****** Object:  Stored Procedure dbo.pCF510cftPigGroupOpen    Script Date: 9/15/2004 1:33:53 PM ******/
CREATE      Proc dbo.pCF510cftPigGroupOpen
	@parm1 varchar (10)
As
Select cftPigGroup.*
From cftPigGroup
JOIN cftPGStatus ON cftPigGroup.PGStatusID=cftPGStatus.PGStatusID
WHERE cftPigGroup.PigGroupID like @parm1 And cftPGStatus.status_transfer='A'
Order By cftPigGroup.PigGroupID, cftPigGroup.PGStatusID







 
