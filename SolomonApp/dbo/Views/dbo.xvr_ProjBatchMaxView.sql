
CREATE VIEW xvr_ProjBatchMaxView AS

Select 
Batch_ID			= a.batch_id,
BatchAmt			= sum(a.amount),
Project				= a.Project, 
Max_Acct			= c.Max_Acct,
Addl_Acct			= min(c.Addl_Acct),
PostedCumulativeAmt	= min(c.PostedCumulativeAmt),	--same as TotalCumulativeAmt since rollup tables have already 
													--been updated for current batch
PostedCumulativeAdj	= min(c.PostedCumulativeAdj),	--Postings to overmax adjustment account in prior postings
Acct_Billing		= min(c.Acct_Billing),
Acct_Overmax		= min(c.Acct_Overmax),
Acct_Overmax_Offset	= min(c.Acct_Overmax_Offset),
gl_acct_overmax		= min(c.gl_acct_overmax),
gl_acct_offset		= min(c.gl_acct_offset),
Max_amount			= min(c.Max_amount),			--Maximum revenue amount for project
TotalCumulativeAmt	= min(c.PostedCumulativeAmt),	--Total amount posted to revenue and overmax reversal 
													--accounts, including revenue postings in current batch 
													--(since the rollup tables have already been posted
AdjustAmt			= CASE 
/*If Total Cumulative Amount is greater than Maximum Amount*/
						WHEN min(c.PostedCumulativeAmt) - min(c.Max_amount) > .0005
/*Adjustment = Maximum - Cumulative*/
						THEN min(c.Max_amount) - min(c.PostedCumulativeAmt) 
						ELSE 
							CASE
/*If Posted Cumulative Adjustment < 0*/
								WHEN min(c.PostedCumulativeAdj) < -.0005
								THEN CASE
/*If Cumulative Amount is less than Maximum Amount*/
										WHEN min(c.PostedCumulativeAmt) - min(c.Max_amount) < -.0005
										THEN CASE 
/*Adjustment = lesser of
	Maximum Amount � Cumulative Amount or
	Prior Cumulative Adjustment*/

												WHEN (-min(c.PostedCumulativeAmt) + min(c.Max_amount)) < -min(c.PostedCumulativeAdj)
												THEN (-min(c.PostedCumulativeAmt) + min(c.Max_amount))
												ELSE -min(c.PostedCumulativeAdj)
											 END
										ELSE 0
									 END
								ELSE 0
							END
						END


from 
PJTran a join 
batch b on 	a.batch_ID	= b.batnbr and		--Join to batch to go directly to unique key in PJTran
			a.system_cd = b.module and
			a.system_cd = 'PA' and		
			a.fiscalno	= b.perpost join
xvr_ProjMaxView c on	a.project = c.project and
				(a.acct = c.max_acct OR a.acct = c.addl_acct)

group by 
a.batch_id,
a.Project,
c.max_acct

