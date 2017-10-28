

CREATE VIEW [dbo].[cfvDayDefinition_WithWeekInfo]
-- CREATED 12/2/05 
-- CREATED BY TJONES
-- Purpose is to join the day definition table to the week definition
-- table for reporting purposes. Simplies some otherwise difficult
-- calculations for typical end-user report writers.
-- Audience: Anaylst Group (John M, Adam D, Sandy G)
--Modified 9/17/08-Josh S.  To add QTR to star schemia
-- modified 2013/03/14 sripley, adding FYPeriod
-- modified 2014/11/20 sripley, tweak picquarter and fyperiod to use fiscalyear not picyear

(DayDate, DayName, PICCycle, PICDayNbr, WeekOfDate,
      FiscalPeriod, FiscalYear, PICWeek, PICYear,PICYear_Week, WeekEndDate, PICQuarter, FYPeriod)
      AS          

SELECT dd.DayDate, dd.DayName, dd.PICCycle, dd.PICDayNbr, 
      dd.WeekOfDate, wd.FiscalPeriod, wd.FiscalYear, wd.PICWeek,
      wd.PICYear,
      right(wd.PICYear,2) + 'WK' + 
      replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.PICWeek)))))
                        + rtrim(convert(char(2),rtrim(wd.PICWeek))),
      wd.WeekEndDate,

--Case When FiscalPeriod in (1,2,3) Then right(wd.PICYear,2)+'QTR01'
--       When FiscalPeriod in (4,5,6) Then right(wd.PICYear,2)+'QTR02'
--       When FiscalPeriod in (7,8,9) Then right(wd.PICYear,2)+'QTR03'
--       Else right(wd.PICYear,2)+'QTR04' End
       
--, right(wd.PICYear,2) + 'Per' + replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.FiscalPeriod)))))
--                        + rtrim(convert(char(2),rtrim(wd.FiscalPeriod)))

Case When FiscalPeriod in (1,2,3) Then right(wd.fiscalYear,2)+'QTR01'
       When FiscalPeriod in (4,5,6) Then right(wd.fiscalYear,2)+'QTR02'
       When FiscalPeriod in (7,8,9) Then right(wd.fiscalYear,2)+'QTR03'
       when fiscalperiod in (10,11,12)  then right(wd.fiscalYear,2)+'QTR04'
       Else right(wd.fiscalYear,2)+'QTR04' 
End
       
, right(wd.fiscalYear,2) + 'Per' + replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.FiscalPeriod)))))
                        + rtrim(convert(char(2),rtrim(wd.FiscalPeriod)))

      FROM cftDayDefinition dd
      JOIN cftWeekDefinition wd ON dd.WeekOfDate = wd.WeekOfDate



