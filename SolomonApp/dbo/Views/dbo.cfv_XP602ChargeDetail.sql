
/****** Object:  View dbo.cfv_XP602ChargeDetail    Script Date: 5/18/2005 3:40:58 PM ******/


/*******************************************************
Project Charge Transaction Details
Used in XP602 Report
********************************************************/

CREATE     View cfv_XP602ChargeDetail
AS
select pjs.project, pj.project_desc, pjs.pjt_entity, pjt.pjt_entity_desc, pjs.batch_id, pjs.acct, pjs.trans_date, pjs.amount, pjs.units, pjs.Crtd_User, 
pjs.Crtd_datetime, pjs.voucher_num, pjs.voucher_line, pjs.tr_comment
From pjtran pjs 
LEFT JOIN pjproj pj ON pjs.project=pj.project
LEFT JOIN pjpent pjt ON pjs.pjt_entity=pjt.pjt_entity
--LEFT JOIN pjchargd pjc ON pjs.batch_id=pjc.batch_id AND pjs.detail_num=pjc.detail_num 
Where pjs.pjt_entity LIKE 'PG%' 
--AND pjs.acct <> ('PIG FEED ISSUE','PIG PURCHASE','PIG MOVE IN','PIG MOVE OUT','PIG TRANSFER OUT','PIG DEATH','PIG MISC EXP','PIG MEDS CHG','PIG OTHER EXP','PIG TRUCKING CHG','PIG VACC CHG','PIG VET CHG','PIG SITE CHG')




