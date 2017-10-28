
CREATE FUNCTION [dbo].[CuryTaskNetProfitPerPeriod] 
( 	
 	@Per int
)
RETURNS TABLE 
AS
RETURN 
(
 	Select  Project,
 	 	Task,
 	 	PerYear,
 	 	Period,
 	 	AccountCategory,
 	 	AccountType, 
 	 	MTDAmt,
 	 	MTDUnit,
 	 	PTDAmt,
 	 	PTDUnit,
 	 	CommitmentAmt,
 	 	CommitmentUnit,
 	 	PTDAmt + CommitmentAmt as PTDPlusComAmt,
 	 	PTDUnit + CommitmentUnit as PTDPlusComUnit,
 	 	EACAmt - CommitmentAmt - PTDAmt AS ETCAmt,
 	 	EACUnit - CommitmentUnit - PTDUnit AS ETCUnit,
 	 	EACAmt,
 	 	EACUnit,
 	 	OrigBudgetAmt,
 	 	OrigBudgetUnit,
 	 	VarianceAmt,
 	 	VarianceUnit
from
(SELECT      PJPTDSUM.project AS Project, 
 	 	 	rtrim(PJPTDSUM.pjt_entity) AS Task, 
 	 	 	PJACTSUM.fsyear_num AS PerYear, 
 	 	 	@Per AS Period, 
 	 	 	rtrim(PJPTDSUM.acct) AS AccountCategory, 
            PJACCT.acct_type AS AccountType, 
 	 	 	CASE WHEN isnumeric(PJACTSUM.projcury_amount_01) = 1 THEN 
 	 	 	 	CASE @Per
                WHEN 0 THEN dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	WHEN 1 THEN dbo.PJACTSUM.projcury_amount_01 
 	 	 	 	WHEN 2 THEN dbo.PJACTSUM.projcury_amount_02 
 	 	 	 	WHEN 3 THEN dbo.PJACTSUM.projcury_amount_03
                WHEN 4 THEN dbo.PJACTSUM.projcury_amount_04 
 	 	 	 	WHEN 5 THEN dbo.PJACTSUM.projcury_amount_05 
 	 	 	 	WHEN 6 THEN dbo.PJACTSUM.projcury_amount_06 
 	 	 	 	WHEN 7 THEN dbo.PJACTSUM.projcury_amount_07
                WHEN 8 THEN dbo.PJACTSUM.projcury_amount_08 
 	 	 	 	WHEN 9 THEN dbo.PJACTSUM.projcury_amount_09 
 	 	 	 	WHEN 10 THEN dbo.PJACTSUM.projcury_amount_10 
 	 	 	 	WHEN 11 THEN dbo.PJACTSUM.projcury_amount_11
                WHEN 12 THEN dbo.PJACTSUM.projcury_amount_12 
 	 	 	 	WHEN 13 THEN dbo.PJACTSUM.projcury_amount_13 
 	 	 	 	WHEN 14 THEN dbo.PJACTSUM.projcury_amount_14 
 	 	 	 	WHEN 15 THEN dbo.PJACTSUM.projcury_amount_15
                END ELSE 0 END AS MTDAmt, 
 	 	 	CASE WHEN isnumeric(PJACTSUM.units_01) = 1 THEN
 	 	 	 	CASE @Per
                WHEN 0 THEN dbo.PJACTSUM.units_bf 
 	 	 	 	WHEN 1 THEN dbo.PJACTSUM.units_01
 	 	 	 	WHEN 2 THEN dbo.PJACTSUM.units_02 
 	 	 	 	WHEN 3 THEN dbo.PJACTSUM.units_03
 	 	 	 	WHEN 4 THEN dbo.PJACTSUM.units_04 
 	 	 	 	WHEN 5 THEN dbo.PJACTSUM.units_05 
 	 	 	 	WHEN 6 THEN dbo.PJACTSUM.units_06 
 	 	 	 	WHEN 7 THEN dbo.PJACTSUM.units_07
 	 	 	 	WHEN 8 THEN dbo.PJACTSUM.units_08 
 	 	 	 	WHEN 9 THEN dbo.PJACTSUM.units_09 
 	 	 	 	WHEN 10 THEN dbo.PJACTSUM.units_10 
 	 	 	 	WHEN 11 THEN dbo.PJACTSUM.units_11
 	 	 	 	WHEN 12 THEN dbo.PJACTSUM.units_12 
 	 	 	 	WHEN 13 THEN dbo.PJACTSUM.units_13 
 	 	 	 	WHEN 14 THEN dbo.PJACTSUM.units_14 
 	 	 	 	WHEN 15 THEN dbo.PJACTSUM.units_15
 	 	 	 	END ELSE 0 END AS MTDUnit,
 	 	 	CASE WHEN isnumeric(PJACTSUM.projcury_amount_01) = 1 THEN
 	 	 	 	 	CASE @Per 
                    WHEN 0 THEN dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 1 THEN dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 2 THEN dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 3 THEN dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 4 THEN dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 5 THEN dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 6 THEN dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 7 THEN dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 8 THEN dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 9 THEN dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 10 THEN dbo.PJACTSUM.projcury_amount_10 + dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 11 THEN dbo.PJACTSUM.projcury_amount_11 + dbo.PJACTSUM.projcury_amount_10 + dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 12 THEN dbo.PJACTSUM.projcury_amount_12 + dbo.PJACTSUM.projcury_amount_11 + dbo.PJACTSUM.projcury_amount_10 + dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 13 THEN dbo.PJACTSUM.projcury_amount_13 + dbo.PJACTSUM.projcury_amount_12 + dbo.PJACTSUM.projcury_amount_11 + dbo.PJACTSUM.projcury_amount_10 + dbo.PJACTSUM.projcury_amount_09 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 14 THEN dbo.PJACTSUM.projcury_amount_14 + dbo.PJACTSUM.projcury_amount_13 + dbo.PJACTSUM.projcury_amount_12 + dbo.PJACTSUM.projcury_amount_11 + dbo.PJACTSUM.projcury_amount_10 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + dbo.PJACTSUM.projcury_amount_05 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	WHEN 15 THEN dbo.PJACTSUM.projcury_amount_15 + dbo.PJACTSUM.projcury_amount_14 + dbo.PJACTSUM.projcury_amount_13 + dbo.PJACTSUM.projcury_amount_12 + dbo.PJACTSUM.projcury_amount_11 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_10 + dbo.PJACTSUM.projcury_amount_09 + dbo.PJACTSUM.projcury_amount_08 + dbo.PJACTSUM.projcury_amount_07 + dbo.PJACTSUM.projcury_amount_06 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.projcury_amount_05 + dbo.PJACTSUM.projcury_amount_04 + dbo.PJACTSUM.projcury_amount_03 + dbo.PJACTSUM.projcury_amount_02 + dbo.PJACTSUM.projcury_amount_01 + dbo.PJACTSUM.projcury_amount_bf 
 	 	 	 	 	END ELSE 0 END AS PTDAmt, 
 	 	 	CASE WHEN isnumeric(PJACTSUM.units_01) = 1 THEN
 	 	 	 	 	CASE @Per 
                    WHEN 0 THEN dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 1 THEN dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 2 THEN dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 3 THEN dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 4 THEN dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 5 THEN dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 6 THEN dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 7 THEN dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 8 THEN dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 9 THEN dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + 
 	 	 	 	 	 	 	 	dbo.PJACTSUM.units_04 + dbo.PJACTSUM.amount_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 10 THEN dbo.PJACTSUM.units_10 + dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 11 THEN dbo.PJACTSUM.units_11 + dbo.PJACTSUM.units_10 + dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 12 THEN dbo.PJACTSUM.units_12 + dbo.PJACTSUM.units_11 + dbo.PJACTSUM.units_10 + dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 13 THEN dbo.PJACTSUM.units_13 + dbo.PJACTSUM.units_12 + dbo.PJACTSUM.units_11 + dbo.PJACTSUM.units_10 + dbo.PJACTSUM.units_09 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 14 THEN dbo.PJACTSUM.units_14 + dbo.PJACTSUM.units_13 + dbo.PJACTSUM.units_12 + dbo.PJACTSUM.units_11 + dbo.PJACTSUM.units_10 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + dbo.PJACTSUM.units_05 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	WHEN 15 THEN dbo.PJACTSUM.units_15 + dbo.PJACTSUM.units_14 + dbo.PJACTSUM.units_13 + dbo.PJACTSUM.units_12 + dbo.PJACTSUM.units_11 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_10 + dbo.PJACTSUM.units_09 + dbo.PJACTSUM.units_08 + dbo.PJACTSUM.units_07 + dbo.PJACTSUM.units_06 + 
 	 	 	 	 	 	 	 	 dbo.PJACTSUM.units_05 + dbo.PJACTSUM.units_04 + dbo.PJACTSUM.units_03 + dbo.PJACTSUM.units_02 + dbo.PJACTSUM.units_01 + dbo.PJACTSUM.units_bf 
 	 	 	 	 	END ELSE 0 END AS PTDUnit,
 	 	 	projcury_com_amount AS CommitmentAmt, 
 	 	 	com_units AS CommitmentUnit, 
 	 	 	projcury_eac_amount AS EACAmt, eac_units AS EACUnit, 
 	 	 	projcury_tot_bud_amt AS OrigBudgetAmt, 
 	 	 	total_budget_units AS OrigBudgetUnit, 
 	 	 	projcury_tot_bud_amt - projcury_eac_amount AS VarianceAmt, 
 	 	 	total_budget_units - eac_units AS VarianceUnit
FROM            PJPTDSUM JOIN
                PJACCT ON PJPTDSUM.acct = PJACCT.acct LEFT OUTER JOIN
                PJACTSUM ON PJACTSUM.project = PJPTDSUM.project AND PJACTSUM.acct = PJPTDSUM.acct AND PJACTSUM.pjt_entity = PJPTDSUM.pjt_entity
WHERE        (PJACCT.acct_type = 'RV' OR
                         PJACCT.acct_type = 'EX'))TNP

UNION

Select  Project,
 	 	Task,
 	 	PerYear,
 	 	Period,
 	 	AccountCategory,
 	 	AccountType, 
 	 	MTDAmt,
 	 	MTDUnit,
 	 	PTDAmt,
 	 	PTDUnit,
 	 	CommitmentAmt,
 	 	CommitmentUnit,
 	 	PTDAmt + CommitmentAmt as PTDPlusComAmt,
 	 	PTDUnit + CommitmentUnit as PTDPlusComUnit,
 	 	EACAmt - CommitmentAmt - PTDAmt AS ETCAmt,
 	 	EACUnit - CommitmentUnit - PTDUnit AS ETCUnit,
 	 	EACAmt,
 	 	EACUnit,
 	 	OrigBudgetAmt,
 	 	OrigBudgetUnit,
 	 	VarianceAmt,
 	 	VarianceUnit
from
(SELECT      PJPTDSUM.project AS Project, 
 	 	 	rtrim(PJPTDSUM.pjt_entity) AS Task, 
 	 	 	NULL AS PerYear, 
 	 	 	@Per AS Period, 
 	 	 	rtrim(PJPTDSUM.acct) AS AccountCategory, 
            PJACCT.acct_type AS AccountType, 
 	 	 	0 AS MTDAmt, 
 	 	 	0 AS MTDUnit,
 	 	 	0 AS PTDAmt, 
 	 	 	0 AS PTDUnit,
 	 	 	projcury_com_amount AS CommitmentAmt, 
 	 	 	com_units AS CommitmentUnit, 
 	 	 	projcury_eac_amount AS EACAmt, eac_units AS EACUnit, 
 	 	 	projcury_tot_bud_amt AS OrigBudgetAmt, 
 	 	 	total_budget_units AS OrigBudgetUnit, 
 	 	 	projcury_tot_bud_amt - projcury_eac_amount AS VarianceAmt, 
 	 	 	total_budget_units - eac_units AS VarianceUnit
FROM            PJPTDSUM JOIN
                PJACCT ON PJPTDSUM.acct = PJACCT.acct LEFT OUTER JOIN
                PJACTSUM ON PJACTSUM.project = PJPTDSUM.project AND PJACTSUM.acct = PJPTDSUM.acct AND PJACTSUM.pjt_entity = PJPTDSUM.pjt_entity
WHERE        (PJACCT.acct_type = 'RV' OR
                         PJACCT.acct_type = 'EX'))TNP
)
