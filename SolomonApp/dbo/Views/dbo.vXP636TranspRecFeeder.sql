

--*************************************************************
--	Purpose: joins foreign tables to cftPMTranspRecord
--	Author: Brian Doyle
--	Date: 07/22/2005
--	Usage: Pig Transport Feeder Pig Report
--	Parms: --
--*************************************************************
CREATE      VIEW dbo.vXP636TranspRecFeeder

AS

Select  Distinct lt.BatchNbr,lt.SourcePigGroupID, lt.DestPigGroupID,lt.RefNbr, lt.OrigRefNbr, lt.MovementDate,lt.SourceContactID, lt.DestContactID,
	lt.PigTypeID,lts.ContactName as SourceFarm, 
	isnull(stand.qty,0) as StandardQty,isnull(sub.qty,0) as SubQty, isnull(nv.qty,0) as NVQty,isnull(dbg.qty,0) as DBGQty,
	isnull(dot.qty,0) as DOTQty,isnull(boar.qty,0) as BoarQty,lt.DocType,
	lt.SourceBarnNbr,lt.SourceRoomNbr, lt.DestBarnNbr, lt.DestRoomNbr,lt.TotalWgt,lt.RecountQty,
	lt.DestFarmQty,
	DestinationQty=Case when lt.RecountQty =0 then lt.DestFarmQty else lt.RecountQty end,
	isnull(pm.EstimatedQty,0) as EstQty, lt.SourceFarmQty,pm.PMID, pm.PMTypeID,
	lt.Crtd_User,lt.AvgWgt,
	Grader=Case when lt.RecountContactID >'' then lt.RecountContactID
			else
			(Select TOP 1 GraderContactID from cftPMGrader g 
					where RefNbr=lt.RefNbr 	
					Order By PMGraderTypeID) end
	From dbo.cftPMTranspRecord lt
	LEFT JOIN dbo.cftPM pm on lt.PMID=pm.PMID and lt.SourceContactID=pm.SourceContactID
	LEFT JOIN cftContact lts on lt.SourceContactID=lts.COntactID
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) stand on lt.RefNbr=stand.RefNbr and stand.PigGradeCatTypeID='01'
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) boar on lt.RefNbr=boar.RefNbr and boar.PigGradeCatTypeID='06'
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) sub on lt.RefNbr=sub.RefNbr and sub.PigGradeCatTypeID='02'
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) nv on lt.RefNbr=nv.RefNbr and nv.PigGradeCatTypeID='03'
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) dbg on lt.RefNbr=dbg.RefNbr and dbg.PigGradeCatTypeID='04'
	LEFT JOIN (Select REfNbr,PigGradeCatTypeID, sum(qty) as qty from cftPMGradeQty Group By RefNbr,PigGradeCatTypeID) dot on lt.RefNbr=dot.RefNbr and dot.PigGradeCatTypeID='05'
	LEFT JOIN cftPMTranspRecord re on lt.RefNbr=re.OrigRefNbr
	where (lt.RecountQty>0 or lt.DestFarmQty>0) and lt.PigTypeID not in ('02','05','07','') and
	re.RefNbr is null and lt.DocType='TR'

 
