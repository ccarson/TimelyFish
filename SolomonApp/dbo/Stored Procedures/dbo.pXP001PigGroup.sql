
/****** Object:  Stored Procedure dbo.pXP001PigGroup    Script Date: 11/14/2005 9:29:17 PM ******/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE  PROC pXP001PigGroup 
	@PigGroupID varchar(10)
	AS
	SELECT * 
	FROM cftPigGroup 
	WHERE PigProdPhaseID In('WTF','FIN') 
	AND PGStatusID In('A','F') 
	AND PigGroupID Like @PigGroupID 
	Order by PigGroupID DESC

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP001PigGroup] TO [MSDSL]
    AS [dbo];

