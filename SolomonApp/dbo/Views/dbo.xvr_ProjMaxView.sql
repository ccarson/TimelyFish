
CREATE VIEW xvr_ProjMaxView AS

Select 
Project				= b.Project, 
Max_Acct			= min(c.acct),
Addl_Acct			= min(c.mx_id03),
PostedCumulativeAmt	= sum(b.Act_Amount ),
PostedCumulativeAdj	= sum(CASE
							WHEN b.acct = c.acct_overmax
							THEN b.act_amount
							ELSE 0
							END),
Acct_Billing		= min(c.acct_billing),
Acct_Overmax		= min(c.acct_overmax),
Acct_Overmax_Offset	= min(c.acct_overmax_offset),
gl_acct_overmax		= min(c.gl_acct_overmax),
gl_acct_offset		= min(c.gl_acct_offset),
Max_amount			= min(a.Max_amount)

from 
PJProjMX a join 
PJProjMX c on a.acct = c.acct and c.project = 'na' join  --necessary because the add'l account and overmax
														 --accounts are not stored in the project-level record
PJPTDRol b on	a.project = b.project and
				(a.acct = b.acct OR b.acct = c.mx_id03 or b.acct = c.acct_overmax)

group by b.Project

