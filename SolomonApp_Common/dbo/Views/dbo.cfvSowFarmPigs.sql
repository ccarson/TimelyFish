CREATE VIEW [dbo].[cfvSowFarmPigs]
AS
select 
C.ContactName As ContactName,
D.PICYear_Week As PIC_Week,
D.FiscalPeriod As FiscalPeriod,
D.FiscalYear As FiscalYear,
D.PICQuarter AS FiscalQTR,

Case When D.FiscalPeriod < 10 Then Rtrim(Cast(D.FiscalYear as char))+'0'+Rtrim(Cast(D.FiscalPeriod as char)) 
      else Rtrim(Cast(D.FiscalYear as char))+Rtrim(Cast(D.FiscalPeriod as char))
            end As FiscalPerPost,

CT.PigGradeCatTypeDesc As PigType,
Sum(G.Qty) As Pigs,

Case    When CT.PigGradeCatTypeDesc = 'Standards' then Sum(G.Qty) 
            When CT.PigGradeCatTypeDesc = 'Dead before Grade' then Sum(G.Qty)
            When CT.PigGradeCatTypeDesc = 'Dead on truck' then Sum(G.Qty)            
            Else 0 End GoodPigs,

S.ContactID, S.SiteID, S.SolomonProjectID, PJ.Project_desc, PJ.GL_Subacct

from dbo.cftPMGradeQty G
join dbo.cftPMTranspRecord T
on t.RefNbr=G.RefNbr
join dbo.cftContact C
on C.ContactID=T.SourceContactID
join dbo.cftPigGradeCatType CT
on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
left join dbo.cftpmtransprecord re
on (T.refnbr = re.origrefnbr)
left join dbo.cfvDayDefinition_WithWeekInfo D
on D.DayDate=T.MovementDate
left join cftSite S
on C.ContactID=S.ContactID

left join pjproj pj
on S.SolomonProjectID=pj.project


where
t.PigTypeID='02'
and left(T.SubTypeID,1) = 'S'
and T.doctype <> 're'
and re.refnbr is null
and PICYear_Week >= '07WK01'

group by
C.ContactName,
D.PICYear_Week,
D.FiscalPeriod,
D.FiscalYear,
CT.PigGradeCatTypeDesc,
S.ContactID,
S.SiteID, 
S.SolomonProjectID, 
PJ.Project_desc,
PJ.GL_Subacct,
D.PICQuarter 
