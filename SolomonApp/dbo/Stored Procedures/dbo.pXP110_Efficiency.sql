CREATE   PROCEDURE pXP110_Efficiency
	@PodID varchar(3), @Gender varchar(1)
	AS
	Select * 
	from cftPigProdEff ef
	Where ef.PodID=@PodID
	AND ef.GenderTypeID=@Gender
	Order by ef.PodID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP110_Efficiency] TO [MSDSL]
    AS [dbo];

