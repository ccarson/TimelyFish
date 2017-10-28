--*************************************************************
--	Purpose:Retrieve first level of litter genetics
--	Author: Charity Anderson
--	Date: 10/13/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowGeneticeL2
AS

Select PICWeek,PICYear,GeneticLine,
	sum(GP*GenCount)/sum(GenCount) as GP,
	sum(PIC*GenCount)/sum(GenCount) as PIC,
	sum(NL*GenCount)/sum(GenCount) as  NL
FROM  
(Select PICWeek,PICYear,GeneticLine,
	GP,	PIC, NL, Count(LineNbr) as GenCount
 from LitterGenetics Group by GenLevel,GeneticLine,PICYear,PICWeek,GP,PIC,NL
) as temp
where PICYEar='2005' and GeneticLine='7700'
group by GeneticLine,PICYear,PICWeek


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowGeneticeL2] TO [se\analysts]
    AS [dbo];

