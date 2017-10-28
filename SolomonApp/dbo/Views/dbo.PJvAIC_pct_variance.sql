
CREATE VIEW [dbo].[PJvAIC_pct_variance]
AS
-- This is part of a group of SQL tables, views, and functions used by the PJAIC_variance SQL stored procedure to
-- generate actual indirect cost amounts.

select aic_pic.period, aic_pic.project, aic_pic.projcuryid, aic_pic.pjt_entity, aic_pic.acct,
       variance_pct = CASE WHEN aic_pic.aic_amount = 0 
                            THEN 0 
                           ELSE (aic_pic.aic_amount - aic_pic.pic_amount) / aic_pic.aic_amount END,
       projcury_variance_pct = CASE WHEN aic_pic.aic_projcury_amount = 0 
                                     THEN 0 
                                    ELSE (aic_pic.aic_projcury_amount - aic_pic.pic_projcury_amount) / aic_pic.aic_projcury_amount END
from (
		select aic.period, aic.project, aic.projcuryid, aic.pjt_entity, aic.acct,
			aic_amount = 
				aic.amount_01 + aic.amount_02 + aic.amount_03 + aic.amount_04 + aic.amount_05 + 
				aic.amount_06 + aic.amount_07 + aic.amount_08 + aic.amount_09 + aic.amount_10 + 
				aic.amount_11 + aic.amount_12 + aic.amount_13 + aic.amount_14 + aic.amount_15,
			aic_projcury_amount = 
				aic.projcury_amount_01 + aic.projcury_amount_02 + aic.projcury_amount_03 + aic.projcury_amount_04 + aic.projcury_amount_05 + 
				aic.projcury_amount_06 + aic.projcury_amount_07 + aic.projcury_amount_08 + aic.projcury_amount_09 + aic.projcury_amount_10 + 
				aic.projcury_amount_11 + aic.projcury_amount_12 + aic.projcury_amount_13 + aic.projcury_amount_14 + aic.projcury_amount_15,
			pic_amount =
				pic.amount_01 + pic.amount_02 + pic.amount_03 + pic.amount_04 + pic.amount_05 + 
				pic.amount_06 + pic.amount_07 + pic.amount_08 + pic.amount_09 + pic.amount_10 + 
				pic.amount_11 + pic.amount_12 + pic.amount_13 + pic.amount_14 + pic.amount_15,
			pic_projcury_amount =
				pic.projcury_amount_01 + pic.projcury_amount_02 + pic.projcury_amount_03 + pic.projcury_amount_04 + pic.projcury_amount_05 + 
				pic.projcury_amount_06 + pic.projcury_amount_07 + pic.projcury_amount_08 + pic.projcury_amount_09 + pic.projcury_amount_10 + 
				pic.projcury_amount_11 + pic.projcury_amount_12 + pic.projcury_amount_13 + pic.projcury_amount_14 + pic.projcury_amount_15
		from PJYTDAIC aic
		inner join PJACTSUM pic
		  on pic.fsyear_num = left(aic.period, 4)
			and pic.project = aic.project
			and pic.pjt_entity = aic.pjt_entity
			and pic.acct = aic.acct) aic_pic
where (aic_pic.aic_amount <> 0
       and aic_pic.aic_amount <> aic_pic.pic_amount)
   or (aic_pic.aic_projcury_amount <> 0
       and aic_pic.aic_projcury_amount <> aic_pic.pic_projcury_amount)

