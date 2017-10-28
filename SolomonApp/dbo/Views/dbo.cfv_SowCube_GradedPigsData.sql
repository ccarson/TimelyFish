





CREATE    VIEW [dbo].[cfv_SowCube_GradedPigsData] 
AS
select
Case
when C.ContactName='C019' then 'C19'
when C.ContactName='C015' and D.PICYear_Week < '08WK02' then 'C015OLD1'
when C.ContactName='C055' and D.PICYear_Week < '08WK04' then 'C055OLD1'
when C.ContactName='C055' and D.PICYear_Week >= '08WK04' and D.PICYear_Week < '09WK50' then 'C055OLD2'
when C.ContactName='C055' and D.PICYear_Week >= '09WK50' and D.PICYear_Week < '10WK47' then 'C055OLD3'
when C.ContactName='C060' and D.PICYear_Week < '08WK08' then 'C060OLD'
when C.ContactName='C054' and D.PICYear_Week < '08WK16' then 'C054OLD1'
when C.ContactName='C043' and D.PICYear_Week < '07WK46' then 'C043OLD1'
when C.ContactName='C044' and D.PICYear_Week < '07WK46' then 'C044OLD1'
when C.ContactName='C023' and D.PICYear_Week < '07WK40' then 'C023OLD'
when C.ContactName='C025' and D.PICYear_Week < '07WK45' then 'C025OLD'
when C.ContactName='M003' and D.PICYear_Week < '09WK24' then 'M003OLD'
when C.ContactName in ('C036','C037') then 'C036'
when C.ContactName in ('C034','C035') then 'C034'
when C.ContactName in ('C032','C033') then 'C032'
when C.ContactName in ('C027','C028') then 'C027'
when C.ContactName in ('C029','C030') then 'C029'
else C.ContactName
end 'All Farrowing',
substring(D.PICYear_Week,1,6) as PICYear_Week,
'NoGenetics' 'Genetic Line',
'No Parity' Parity,
Case
when CT.PigGradeCatTypeDesc='Boars' then 'BoarsQty'
when CT.PigGradeCatTypeDesc='Junks (NV)' then 'NVsQty'
when CT.PigGradeCatTypeDesc='Standards' then 'StandardsQty'
when CT.PigGradeCatTypeDesc='Dead on Truck' then 'DOTQty'
when CT.PigGradeCatTypeDesc='Dead before Grade' then 'DBGQty'
when CT.PigGradeCatTypeDesc='Sub Standards' then 'SubsQty'
else CT.PigGradeCatTypeDesc
end Account,
Sum(G.Qty) Data
from SolomonApp.dbo.cftPMGradeQty G
join SolomonApp.dbo.cftPMTranspRecord T
on t.RefNbr=G.RefNbr
join SolomonApp.dbo.cftContact C
on C.ContactID=T.SourceContactID
join SolomonApp.dbo.cftPigGradeCatType CT
on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
left join SolomonApp.dbo.cftpmtransprecord re
on (T.refnbr = re.origrefnbr)
left join SolomonApp.dbo.cfvDayDefinition_WithWeekInfo D
on D.DayDate=T.MovementDate
where
--t.Movementdate between '12/31/2006' and '12/29/2007' and
t.PigTypeID='02'
and left(T.SubTypeID,1) = 'S'
and T.doctype <> 're'
and re.refnbr is null
and PICYear_Week >= '07WK01'
--and PICYear_Week >= '09WK01'
--and CT.PigGradeCatTypeDesc in ('Dead before Grade','Dead on Truck','Standards')
group by
Case
when C.ContactName='C019' then 'C19'
when C.ContactName='C015' and D.PICYear_Week < '08WK02' then 'C015OLD1'
when C.ContactName='C055' and D.PICYear_Week < '08WK04' then 'C055OLD1'
when C.ContactName='C055' and D.PICYear_Week >= '08WK04' and D.PICYear_Week < '09WK50' then 'C055OLD2'
when C.ContactName='C055' and D.PICYear_Week >= '09WK50' and D.PICYear_Week < '10WK47' then 'C055OLD3'
when C.ContactName='C060' and D.PICYear_Week < '08WK08' then 'C060OLD'
when C.ContactName='C054' and D.PICYear_Week < '08WK16' then 'C054OLD1'
when C.ContactName='C043' and D.PICYear_Week < '07WK46' then 'C043OLD1'
when C.ContactName='C044' and D.PICYear_Week < '07WK46' then 'C044OLD1'
when C.ContactName='C023' and D.PICYear_Week < '07WK40' then 'C023OLD'
when C.ContactName='C025' and D.PICYear_Week < '07WK45' then 'C025OLD'
when C.ContactName='M003' and D.PICYear_Week < '09WK24' then 'M003OLD'
when C.ContactName in ('C036','C037') then 'C036'
when C.ContactName in ('C034','C035') then 'C034'
when C.ContactName in ('C032','C033') then 'C032'
when C.ContactName in ('C027','C028') then 'C027'
when C.ContactName in ('C029','C030') then 'C029'
else C.ContactName
end,
D.PICYear_Week,
Case
when CT.PigGradeCatTypeDesc='Boars' then 'BoarsQty'
when CT.PigGradeCatTypeDesc='Junks (NV)' then 'NVsQty'
when CT.PigGradeCatTypeDesc='Standards' then 'StandardsQty'
when CT.PigGradeCatTypeDesc='Dead on Truck' then 'DOTQty'
when CT.PigGradeCatTypeDesc='Dead before Grade' then 'DBGQty'
when CT.PigGradeCatTypeDesc='Sub Standards' then 'SubsQty'
else CT.PigGradeCatTypeDesc
end




