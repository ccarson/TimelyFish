
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.cfv_StartCharge    Script Date: 3/16/2005 2:48:57 PM ******/

/****** Object:  View dbo.cfv_StartCharge    Script Date: 3/16/2005 8:54:47 AM ******/


CREATE   View cfv_StartCharge
AS

select pj.project, pj.pjt_entity, pg.SiteContactID, pg.PigGroupID, pj.act_amount/st.Qty AS StartValue
From pjptdsum pj 
JOIN cfv_GroupStart st ON pj.pjt_entity=st.TaskID
JOIN cftPigGroup pg ON pj.pjt_entity=pg.TaskID
Where pj.acct='PIG PURCHASE' OR pj.acct='PIG TRANSFER IN'



 