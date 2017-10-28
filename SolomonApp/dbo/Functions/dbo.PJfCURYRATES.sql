
CREATE FUNCTION [dbo].[PJfCURYRATES] (@fromCuryID CHAR(4),
                                      @toCuryID CHAR(4),
                                      @rateType CHAR(6),
                                      @fiscalYear CHAR (4))
RETURNS TABLE 
AS

-- Dependent on: GetCalendarEndDateOfPeriod() function

RETURN
    select fromcuryid = @fromCuryID, fromcurydecpl = fc.DecPl, tocuryid = @toCuryID, tocurydecpl = tc.DecPl, ratetype = @rateType,
           rate_01 = 1, rate_02 = 1, rate_03 = 1, rate_04 = 1, rate_05 = 1,
           rate_06 = 1, rate_07 = 1, rate_08 = 1, rate_09 = 1, rate_10 = 1,
           rate_11 = 1, rate_12 = 1, rate_13 = 1, rate_14 = 1, rate_15 = 1,
           MultDiv_01 = 'M', MultDiv_02 = 'M', MultDiv_03 = 'M', MultDiv_04 = 'M', MultDiv_05 = 'M',
           MultDiv_06 = 'M', MultDiv_07 = 'M', MultDiv_08 = 'M', MultDiv_09 = 'M', MultDiv_10 = 'M',
           MultDiv_11 = 'M', MultDiv_12 = 'M', MultDiv_13 = 'M', MultDiv_14 = 'M', MultDiv_15 = 'M'
     from GLSetup with (nolock)
     inner join Currncy fc with (nolock)
      on fc.CuryId = @fromCuryID
     inner join Currncy tc with (nolock)
      on tc.CuryId = @toCuryID
     where BaseCuryId = @fromCuryID and @fromCuryID = @toCuryID
           or not exists(select * from CMSetup with (nolock))
    union
    select fromcuryid = @fromCuryID, fromcurydecpl = fc.DecPl, tocuryid = @toCuryID, tocurydecpl = tc.DecPl, ratetype = @rateType,
           rate_01 = isnull(c01.Rate, 0), rate_02 = isnull(c02.Rate, 0), rate_03 = isnull(c03.Rate, 0), rate_04 = isnull(c04.Rate, 0), rate_05 = isnull(c05.Rate, 0),
           rate_06 = isnull(c06.Rate, 0), rate_07 = isnull(c07.Rate, 0), rate_08 = isnull(c08.Rate, 0), rate_09 = isnull(c09.Rate, 0), rate_10 = isnull(c10.Rate, 0),
           rate_11 = isnull(c11.Rate, 0), rate_12 = isnull(c12.Rate, 0), rate_13 = isnull(c13.Rate, 0), rate_14 = isnull(c14.Rate, 0), rate_15 = isnull(c15.Rate, 0),
           MultDiv_01 = isnull(c01.MultDiv, ''), MultDiv_02 = isnull(c02.MultDiv, ''), MultDiv_03 = isnull(c03.MultDiv, ''), MultDiv_04 = isnull(c04.MultDiv, ''), MultDiv_05 = isnull(c05.MultDiv, ''),
           MultDiv_06 = isnull(c06.MultDiv, ''), MultDiv_07 = isnull(c07.MultDiv, ''), MultDiv_08 = isnull(c08.MultDiv, ''), MultDiv_09 = isnull(c09.MultDiv, ''), MultDiv_10 = isnull(c10.MultDiv, ''),
           MultDiv_11 = isnull(c11.MultDiv, ''), MultDiv_12 = isnull(c12.MultDiv, ''), MultDiv_13 = isnull(c13.MultDiv, ''), MultDiv_14 = isnull(c14.MultDiv, ''), MultDiv_15 = isnull(c15.MultDiv, '')
     from CMSetup with (nolock)
     inner join Currncy fc
     on fc.CuryId = @fromCuryID
     inner join Currncy tc
     on tc.CuryId = @toCuryID
     left join CuryRate c01 with (nolock)
     on c01.FromCuryId = @fromCuryID
       and c01.ToCuryId = @toCuryID
       and c01.RateType = @rateType
       and c01.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'01'))
     left join CuryRate c02 with (nolock)
     on c02.FromCuryId = @fromCuryID
       and c02.ToCuryId = @toCuryID
       and c02.RateType = @rateType
       and c02.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'02'))
     left join CuryRate c03 with (nolock)
     on c03.FromCuryId = @fromCuryID
       and c03.ToCuryId = @toCuryID
       and c03.RateType = @rateType
       and c03.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'03'))
     left join CuryRate c04 with (nolock)
     on c04.FromCuryId = @fromCuryID
       and c04.ToCuryId = @toCuryID
       and c04.RateType = @rateType
       and c04.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'04'))
     left join CuryRate c05 with (nolock)
     on c05.FromCuryId = @fromCuryID
       and c05.ToCuryId = @toCuryID
       and c05.RateType = @rateType
       and c05.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'05'))
     left join CuryRate c06 with (nolock)
     on c06.FromCuryId = @fromCuryID
       and c06.ToCuryId = @toCuryID
       and c06.RateType = @rateType
       and c06.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'06'))
     left join CuryRate c07 with (nolock)
     on c07.FromCuryId = @fromCuryID
       and c07.ToCuryId = @toCuryID
       and c07.RateType = @rateType
       and c07.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'07'))
     left join CuryRate c08 with (nolock)
     on c08.FromCuryId = @fromCuryID
       and c08.ToCuryId = @toCuryID
       and c08.RateType = @rateType
       and c08.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'08'))
     left join CuryRate c09 with (nolock)
     on c09.FromCuryId = @fromCuryID
       and c09.ToCuryId = @toCuryID
       and c09.RateType = @rateType
       and c09.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'09'))
     left join CuryRate c10 with (nolock)
     on c10.FromCuryId = @fromCuryID
       and c10.ToCuryId = @toCuryID
       and c10.RateType = @rateType
       and c10.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'10'))
     left join CuryRate c11 with (nolock)
     on c11.FromCuryId = @fromCuryID
       and c11.ToCuryId = @toCuryID
       and c11.RateType = @rateType
       and c11.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'11'))
     left join CuryRate c12 with (nolock)
     on c12.FromCuryId = @fromCuryID
       and c12.ToCuryId = @toCuryID
       and c12.RateType = @rateType
       and c12.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'12'))
     left join CuryRate c13 with (nolock)
     on c13.FromCuryId = @fromCuryID
       and c13.ToCuryId = @toCuryID
       and c13.RateType = @rateType
       and c13.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'13'))
     left join CuryRate c14 with (nolock)
     on c14.FromCuryId = @fromCuryID
       and c14.ToCuryId = @toCuryID
       and c14.RateType = @rateType
       and c14.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'14'))
     left join CuryRate c15 with (nolock)
     on c15.FromCuryId = @fromCuryID
       and c15.ToCuryId = @toCuryID
       and c15.RateType = @rateType
       and c15.EffDate = (select max(c.Effdate)
                         from CuryRate c with (nolock)
                         where c.FromCuryID = @fromCuryID
                           and c.ToCuryID = @toCuryID
                           and c.RateType = @rateType
                           and c.EffDate <= dbo.GetCalendarEndDateOfGLPeriod(@fiscalYear+'15'))
     where (select BaseCuryId from GLSetup with (nolock)) <> @fromCuryID or @fromCuryID <> @toCuryID
       and exists(select * from CMSetup with (nolock))


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfCURYRATES] TO [MSDSL]
    AS [dbo];

