--Created on 01/24/2007 by Dave Killion
--This SP returns all destination pig groups that are missing
--a pigprodpodid that are headed to a finishing farm and have
--a source pig group. This SP is used by the application 
--FixPigProdPod.
/**
***************************************************************
	Created for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/

CREATE PROCEDURE Dbo.SPFixMissingPigProdPods000
 AS

select
	cftpm.PMID,
	cftpm.DestPigGroupID,
	cftpm.TranSubTypeID,
	cftpiggroup.PigGenderTypeID,
	pigprodpodid,
	SourcePigGroupID
from 
cftPigGroup (Nolock)
left JOIN cftPM (NoLock) ON CFTPM.DESTPIGGROUPID = CFTPIGGROUP.PIGGROUPID
where 
pigprodpodid = ''
and
cftpm.TranSubtypeID = 'NF'
and
cftpm.SourcePigGroupID <> ''
order by CFTPM.DESTPIGGROUPID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SPFixMissingPigProdPods000] TO [MSDSL]
    AS [dbo];

