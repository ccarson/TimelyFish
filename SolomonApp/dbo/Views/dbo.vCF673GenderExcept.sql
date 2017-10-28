--*************************************************************
--	Purpose:Active groups with Gender and Qtys from Xfer sheets
--	Author: Charity Anderson
--	Date:6/6/2005
--	Usage: Feed Gender Exception report
--	Parms:
--*************************************************************

CREATE VIEW dbo.vCF673GenderExcept
AS
Select *
From
(Select pg.PigGroupID, pg.EstInventory,pg.Description,pg.PigGenderTypeID as PGGender,pg.PigProdPhaseID,
tr.PigGenderTypeID as TRGender,Sum(tr.DestFarmQty) as Qty
FROM
cftPigGroup pg 
JOIN cftPMTranspRecord tr on pg.PigGroupID=tr.DestPigGroupID
LEFT JOIN cftPMTranspRecord rev on rev.OrigRefNbr=tr.RefNbr
where pg.PGStatusID ='A' 
and CF10=0-- and pg.PigGenderTypeID<>tr.PigGenderTypeID
and rev.refNbr is null and tr.DocType<>'RE' and tr.PigGenderTypeID>''
Group by pg.PigProdPhaseID,pg.PigGroupID,pg.EstInventory,
pg.Description,pg.PigGenderTypeID,tr.PigGenderTypeID) as temp
where Qty>0


 