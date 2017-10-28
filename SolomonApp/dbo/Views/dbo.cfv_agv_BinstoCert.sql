--*************************************************************
--	Purpose: Non-creep feed bins,from pig groups that are active or tentitive close, that need certification because they received 
--  feed that has a feed withdrawal
--	Author: Brent Fredrick/Sue Matter
--	Date: 11/16/2006
--	Usage: Packer Certification 
--	Parms: 
--	       
--*************************************************************
--*****Caution: As medications within diet change, diet parameters will need to be modified!!!!********

CREATE   View [dbo].[cfv_agv_BinstoCert]
AS
select distinct pg.piggroupID, bn.binnbr, max(pc.withdrawaldate)as MaxWithdrawalDate, 'MedFeed' As NeedBinCertification
--Modifications by Sue for efficiency this is already being done in the where clause
					--case when (fo.invtiddel like '%41%' or 
				--			fo.invtiddel like '%42%' or
			--				fo.invtiddel like '%43%' or
		--					fo.invtiddel like '%44%' or
	--						fo.invtiddel like '%51%' )
--							 then 'MedFeed' else '' end as NeedBinCertification

from cftpiggroup pg
join cftbin bn	on pg.sitecontactID = bn.contactID and pg.barnnbr = bn.barnnbr 
join cftfeedorder fo on pg.piggroupID = fo.piggroupID and bn.binnbr= fo.binnbr 
--Modification by sue this information is in a table, the view does not need to be used
--left join cfvpackercertification pc on pg.piggroupID = pc.piggroupID and bn.binnbr= pc.binnbr 
join cftbintype bt on bn.bintypeID = bt.bintypeID 
left join cftBinCert pc on pg.PigGroupID=pc.PigGroupID
--modifications by Sue no information from this table is being used
--left join cftpm pm on pg.piggroupID = pm.sourcepiggroupID
where (pg.pgstatusID = 'a' or pg.pgstatusID = 't') and bt.description not like '%creep%' AND pg.pigprodphaseID in ('FIN','WTF','TEF')
And ((fo.invtiddel like '%41%' or fo.invtiddel like '%42%' or fo.invtiddel like '%43%' or fo.invtiddel like '%44%' or fo.invtiddel like '%51%' ))
group by pg.piggroupID,
		bn.binnbr--,
		--fo.invtiddel,withdrawaldate
--Modifications by Sue this should be done in the where clause
--Having			(fo.invtiddel like '%41%' or 
--				fo.invtiddel like '%42%' or
--				fo.invtiddel like '%43%' or
--				fo.invtiddel like '%44%' or
--				fo.invtiddel like '%51%' ) 
--Modifications by Sue the order by is not typically used in a view, this is done when you query the view
--order by pg.piggroupID
