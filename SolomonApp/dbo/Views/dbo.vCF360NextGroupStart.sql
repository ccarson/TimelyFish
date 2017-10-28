--*************************************************************
--	Purpose:Pig Group with the next group's start date
--	Author: Charity Anderson
--	Date: 1/12/2005
--	Usage: Feed Order Exception		 
--	Parms: 
--*************************************************************

Create view vCF360NextGroupStart 
as 
Select Distinct pg.PigGroupID,NextStart=(Select Top 1 EstStartDate 
	from cftPigGroup p LEFT JOIN cftPigGroupRoom ro 
	on p.PigGroupID=ro.PigGroupID where 
	p.PIgGroupID<>pg.PigGroupID and p.SiteContactID=pg.SIteContactID 
	and p.BarnNbr=pg.BarnNbr and RoomNbr=r.RoomNbr
	and p.EstStartDate>pg.EstStartDate
	and p.PGStatusID<>'I' and p.PGStatusID<>'T' 
	Order by EstStartDate DESC
	),NextGroup=(Select Top 1 p.PigGroupID 
	from cftPigGroup p LEFT JOIN cftPigGroupRoom ro 
	on p.PigGroupID=ro.PigGroupID where 
	p.PIgGroupID<>pg.PigGroupID and p.SiteContactID=pg.SIteContactID 
	and p.BarnNbr=pg.BarnNbr and RoomNbr=r.RoomNbr
	and p.EstStartDate>pg.EstStartDate
	and p.PGStatusID<>'I' and p.PGStatusID<>'T' 
	Order by EstStartDate DESC
	)

from cftPigGroup pg
LEFT JOIN cftPigGroupRoom r
on pg.PigGroupID=r.PigGroupID




 