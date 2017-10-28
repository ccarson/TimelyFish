
Create Proc GetEffectiveCuryRate @AdjdCuryID varchar (4), @BaseCuryID varchar (4),  @AdjdCuryRateType varchar (6)as
 Declare
	@AdjgEffDate smalldatetime
	
	select @AdjgEffDate = max(c2.Effdate)
                                from CuryRate c2 (nolock)
                                where c2.FromCuryID = @AdjdCuryID 
                                          AND c2.ToCuryID = @BaseCuryID 
                                          AND c2.RateType = @AdjdCuryRateType 
                                          AND c2.EffDate <= getdate()
 
	Select c.rate, c.MultDiv, c.EffDate
                  from curyrate c (nolock)
                    where c.FromCuryId = @AdjDCuryID and c.ToCuryId = @basecuryid
                    and c.RateType = @AdjdCuryRateType and c.EffDate = @AdjgEffDate

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetEffectiveCuryRate] TO [MSDSL]
    AS [dbo];

