
CREATE FUNCTION [dbo].[ProjectNetProfitPerPeriod] 
(	
	@Per int
)
RETURNS TABLE 
AS
RETURN 
(
	select PerYear, Period, Project, AcctCategory, AcctType, MTDAmt, MTDUnit, PTDAmt, PTDUnit, CommitmentAmt, 
	CommitmentUnit, PTDAmt + CommitmentAmt as PTDPlusCommitAmt,
	PTDUnit + CommitmentUnit as PTDPlusCommitUnit, EACAmt - PTDAmt - CommitmentAmt AS ETCAmt,
	EACUnits - PTDUnit - CommitmentUnit AS ETCUnit, EACAmt, EACUnits, OriginalBudgetAmt,
	OriginalBudgetUntis, OriginalBudgetAmt - EACAmt AS VarianceAmt, OriginalBudgetUntis - EACUnits AS VarianceUnit
	FROM
	(Select distinct A.PerYear, @Per as Period,
		CASE WHEN A.Project is null THEN B.Project ELSE A.Project END AS Project,
		CASE WHEN A.AcctCategory is null THEN B.AcctCategory ELSE A.AcctCategory END AS AcctCategory,
		CASE WHEN A.AcctType is null THEN B.AcctType ELSE A.AcctType END AS AcctType,
		CASE WHEN A.MTDAmt is null THEN 0 ELSE A.MTDAmt END AS MTDAmt,
		CASE WHEN A.MTDUnit is null THEN 0 ELSE A.MTDUnit END AS MTDUnit,
		CASE WHEN A.PTDAmt is null THEN 0 ELSE A.PTDAmt END AS PTDAmt,
		CASE WHEN A.PTDUnit is null THEN 0 ELSE A.PTDUnit END AS PTDUnit,
		CASE WHEN A.CommitmentAmt is null THEN 0 ELSE A.CommitmentAmt END AS CommitmentAmt,
		CASE WHEN A.CommitmentUnit is null THEN 0 ELSE A.CommitmentUnit END AS CommitmentUnit,
		CASE WHEN B.EACAmt is null THEN 0 ELSE B.EACAmt END AS EACAmt,
		CASE WHEN B.EACUnits is null THEN 0 ELSE B.EACUnits END AS EACUnits,
		CASE WHEN B.OriginalBudgetAmt is null THEN 0 ELSE B.OriginalBudgetAmt END AS OriginalBudgetAmt,
		CASE WHEN B.OriginalBudgetUntis is null THEN 0 ELSE B.OriginalBudgetUntis END AS OriginalBudgetUntis
	from	(Select distinct
			CASE WHEN ACT.PerYear is null THEN COM.PerYear ELSE ACT.PerYear END AS PerYear,
			CASE WHEN ACT.Project is null THEN COM.Project ELSE ACT.Project END AS Project,
			CASE WHEN ACT.AcctCategory is null THEN COM.AcctCategory ELSE ACT.AcctCategory END AS AcctCategory,
			CASE WHEN ACT.AcctType is null THEN COM.AcctType ELSE ACT.AcctType END AS AcctType,
			CASE WHEN ACT.MTDAmt is null THEN 0 ELSE ACT.MTDAmt END AS MTDAmt,
			CASE WHEN ACT.MTDUnit is null THEN 0 ELSE ACT.MTDUnit END AS MTDUnit,
			CASE WHEN ACT.PTDAmt is null THEN 0 ELSE ACT.PTDAmt END AS PTDAmt,
			CASE WHEN ACT.PTDUnit is null THEN 0 ELSE ACT.PTDUnit END AS PTDUnit,
			CASE WHEN COM.CommitmentAmt is null THEN 0 ELSE COM.CommitmentAmt END AS CommitmentAmt,
			CASE WHEN COM.CommitmentUnit is null THEN 0 ELSE COM.CommitmentUnit END AS CommitmentUnit
		from (SELECT	pjactrol.fsyear_num AS PerYear,
						PJACTROL.project AS Project, 
						RTRIM(PJACTROL.acct) AS AcctCategory,
						rtrim(pjacct.acct_type) AS AcctType, 
						CASE WHEN isnumeric(PJACTROL.amount_01) = 1 THEN 
							CASE @Per
							WHEN 0 THEN dbo.PJACTROL.amount_bf 
							WHEN 1 THEN dbo.PJACTROL.amount_01 
							WHEN 2 THEN dbo.PJACTROL.amount_02 
							WHEN 3 THEN dbo.PJACTROL.amount_03
							WHEN 4 THEN dbo.PJACTROL.amount_04 
							WHEN 5 THEN dbo.PJACTROL.amount_05 
							WHEN 6 THEN dbo.PJACTROL.amount_06 
							WHEN 7 THEN dbo.PJACTROL.amount_07
							WHEN 8 THEN dbo.PJACTROL.amount_08 
							WHEN 9 THEN dbo.PJACTROL.amount_09 
							WHEN 10 THEN dbo.PJACTROL.amount_10 
							WHEN 11 THEN dbo.PJACTROL.amount_11 
							WHEN 12 THEN dbo.PJACTROL.amount_12 
							WHEN 13 THEN dbo.PJACTROL.amount_13 
							WHEN 14 THEN dbo.PJACTROL.amount_14
							WHEN 15 THEN dbo.PJACTROL.amount_15 
							END ELSE 0 END AS MTDAmt, 
						CASE WHEN isnumeric(PJACTROL.amount_01) = 1 THEN 
							CASE @Per 
						    WHEN 0 THEN dbo.PJACTROL.units_bf 
							WHEN 1 THEN dbo.PJACTROL.units_01 
							WHEN 2 THEN dbo.PJACTROL.units_02
							WHEN 3 THEN dbo.PJACTROL.units_03
						    WHEN 4 THEN dbo.PJACTROL.units_04 
							WHEN 5 THEN dbo.PJACTROL.units_05
							WHEN 6 THEN dbo.PJACTROL.units_06 
							WHEN 7 THEN dbo.PJACTROL.units_07
						    WHEN 8 THEN dbo.PJACTROL.units_08 
							WHEN 9 THEN dbo.PJACTROL.units_09 
							WHEN 10 THEN dbo.PJACTROL.units_10 
							WHEN 11 THEN dbo.PJACTROL.units_11
						    WHEN 12 THEN dbo.PJACTROL.units_12 
							WHEN 13 THEN dbo.PJACTROL.units_13 
							WHEN 14 THEN dbo.PJACTROL.units_14 
							WHEN 15 THEN dbo.PJACTROL.units_15
						    END ELSE 0 END AS MTDUnit, 
						CASE WHEN isnumeric(PJACTROL.amount_01) = 1 THEN
							CASE @Per 
						    WHEN 0 THEN dbo.PJACTROL.amount_bf 
							WHEN 1 THEN dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 2 THEN dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 3 THEN dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 4 THEN dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 5 THEN dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + 
										dbo.PJACTROL.amount_bf 
							WHEN 6 THEN dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + 
										dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 7 THEN dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + 
										dbo.PJACTROL.amount_02  + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 8 THEN dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + 
										dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 9 THEN dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + 
										dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 10 THEN dbo.PJACTROL.amount_10 + dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + 
										dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + 
										dbo.PJACTROL.amount_bf 
							WHEN 11 THEN dbo.PJACTROL.amount_11 + dbo.PJACTROL.amount_10 + dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + 
										dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + 
										dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 12 THEN dbo.PJACTROL.amount_12 + dbo.PJACTROL.amount_11 + dbo.PJACTROL.amount_10 + dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + 
										dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + 
										dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 13 THEN dbo.PJACTROL.amount_13 + dbo.PJACTROL.amount_12 + dbo.PJACTROL.amount_11 + dbo.PJACTROL.amount_10 + dbo.PJACTROL.amount_09 + 
										dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + 
										dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 14 THEN dbo.PJACTROL.amount_14 + dbo.PJACTROL.amount_13 + dbo.PJACTROL.amount_12 + dbo.PJACTROL.amount_11 + dbo.PJACTROL.amount_10 + 
										dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + dbo.PJACTROL.amount_05 + 
										dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							WHEN 15 THEN dbo.PJACTROL.amount_15 + dbo.PJACTROL.amount_14 + dbo.PJACTROL.amount_13 + dbo.PJACTROL.amount_12 + dbo.PJACTROL.amount_11 + 
										dbo.PJACTROL.amount_10 + dbo.PJACTROL.amount_09 + dbo.PJACTROL.amount_08 + dbo.PJACTROL.amount_07 + dbo.PJACTROL.amount_06 + 
										dbo.PJACTROL.amount_05 + dbo.PJACTROL.amount_04 + dbo.PJACTROL.amount_03 + dbo.PJACTROL.amount_02 + dbo.PJACTROL.amount_01 + dbo.PJACTROL.amount_bf 
							END ELSE 0 END AS PTDAmt, 
						CASE WHEN isnumeric(PJACTROL.units_01) = 1 THEN
							CASE @Per
						    WHEN 0 THEN dbo.PJACTROL.units_bf 
							WHEN 1 THEN dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 2 THEN dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 3 THEN dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 4 THEN dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 5 THEN dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + 
										dbo.PJACTROL.units_bf 
							WHEN 6 THEN dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + 
										dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 7 THEN dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + 
										dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 8 THEN dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + 
										dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 9 THEN dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + 
										dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 10 THEN dbo.PJACTROL.units_10 + dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + 
										dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + 
										dbo.PJACTROL.units_bf 
							WHEN 11 THEN dbo.PJACTROL.units_11 + dbo.PJACTROL.units_10 + dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + 
										dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 +
										dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 12 THEN dbo.PJACTROL.units_12 + dbo.PJACTROL.units_11 + dbo.PJACTROL.units_10 + dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 +
										dbo.PJACTROL.units_07+ dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + 
										dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 13 THEN dbo.PJACTROL.units_13 + dbo.PJACTROL.units_12 + dbo.PJACTROL.units_11 + dbo.PJACTROL.units_10 + dbo.PJACTROL.units_09 + 
										dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + 
										dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 14 THEN dbo.PJACTROL.units_14 + dbo.PJACTROL.units_13 + dbo.PJACTROL.units_12 + dbo.PJACTROL.units_11 + dbo.PJACTROL.units_10 + 
										dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + dbo.PJACTROL.units_05 + 
										dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02+ dbo.PJACTROL.units_01 + dbo.PJACTROL.units_bf 
							WHEN 15 THEN dbo.PJACTROL.units_15 + dbo.PJACTROL.units_14 + dbo.PJACTROL.units_13 + dbo.PJACTROL.units_12 + dbo.PJACTROL.units_11 + 
										dbo.PJACTROL.units_10 + dbo.PJACTROL.units_09 + dbo.PJACTROL.units_08 + dbo.PJACTROL.units_07 + dbo.PJACTROL.units_06 + 
										dbo.PJACTROL.units_05 + dbo.PJACTROL.units_04 + dbo.PJACTROL.units_03 + dbo.PJACTROL.units_02 + dbo.PJACTROL.units_01+ dbo.PJACTROL.units_bf 
							END ELSE 0 END AS PTDUnit
                FROM            pjacct JOIN
                                pjactrol ON pjactrol.acct = pjacct.acct
                WHERE			(pjacct.acct_type = 'RV' OR
									pjacct.acct_type = 'EX')
Union
SELECT			NULL,
				PJACTROL.project, 
				RTRIM(PJACTROL.acct),
                rtrim(pjacct.acct_type), 0, 0, 0, 0
                FROM            pjacct JOIN
                                pjactrol ON pjactrol.acct = pjacct.acct
                WHERE			(pjacct.acct_type = 'RV' OR
									pjacct.acct_type = 'EX')) ACT FULL OUTER JOIN
(SELECT        PJCOMROL.fsyear_num AS PerYear,
				PJCOMROL.project AS Project, 
				RTRIM(dbo.PJCOMROL.acct) AS AcctCategory, 
                rtrim(pjacct.acct_type) AS AcctType, 
				
					CASE WHEN isnumeric(PJCOMROL.amount_01) = 1 THEN 
						CASE @Per
                        WHEN 0 THEN dbo.PJCOMROL.amount_bf 
						WHEN 1 THEN dbo.PJCOMROL.amount_01 
						WHEN 2 THEN dbo.PJCOMROL.amount_02 
						WHEN 3 THEN dbo.PJCOMROL.amount_03 
						WHEN 4 THEN dbo.PJCOMROL.amount_04 
						WHEN 5 THEN dbo.PJCOMROL.amount_05 
						WHEN 6 THEN dbo.PJCOMROL.amount_06
                        WHEN 7 THEN dbo.PJCOMROL.amount_07
						WHEN 8 THEN dbo.PJCOMROL.amount_08 
						WHEN 9 THEN dbo.PJCOMROL.amount_09 
						WHEN 10 THEN dbo.PJCOMROL.amount_10 
						WHEN 11 THEN dbo.PJCOMROL.amount_11 
						WHEN 12 THEN dbo.PJCOMROL.amount_12 
						WHEN 13 THEN dbo.PJCOMROL.amount_13
						WHEN 14 THEN dbo.PJCOMROL.amount_14 
						WHEN 15 THEN dbo.PJCOMROL.amount_15 
						END ELSE 0 END AS CommitmentAmt, 
                    CASE WHEN isnumeric(PJCOMROL.amount_01) = 1 THEN
						CASE @Per
                        WHEN 0 THEN dbo.PJCOMROL.units_bf 
						WHEN 1 THEN dbo.PJCOMROL.units_01 
						WHEN 2 THEN dbo.PJCOMROL.units_02 
						WHEN 3 THEN dbo.PJCOMROL.units_03
						WHEN 4 THEN dbo.PJCOMROL.units_04 
						WHEN 5 THEN dbo.PJCOMROL.units_05 
						WHEN 6 THEN dbo.PJCOMROL.units_06 
						WHEN 7 THEN dbo.PJCOMROL.units_07
						WHEN 8 THEN dbo.PJCOMROL.units_08 
						WHEN 9 THEN dbo.PJCOMROL.units_09 
						WHEN 10 THEN dbo.PJCOMROL.units_10 
						WHEN 11 THEN dbo.PJCOMROL.units_11
						WHEN 12 THEN dbo.PJCOMROL.units_12 
						WHEN 13 THEN dbo.PJCOMROL.units_13 
						WHEN 14 THEN dbo.PJCOMROL.units_14 
						WHEN 15 THEN dbo.PJCOMROL.units_15
                        END ELSE 0 END AS CommitmentUnit
					
                FROM            PJCOMROL JOIN
                                pjacct ON PJCOMROL.acct = pjacct.acct
                WHERE			(pjacct.acct_type = 'RV' OR
									pjacct.acct_type = 'EX')
UNION
SELECT			NULL,
				PJCOMROL.project, 
				RTRIM(dbo.PJCOMROL.acct), 
                rtrim(pjacct.acct_type), 0, 0
					
                FROM            PJCOMROL JOIN
                                pjacct ON PJCOMROL.acct = pjacct.acct
                WHERE			(pjacct.acct_type = 'RV' OR
									pjacct.acct_type = 'EX')) COM on ACT.AcctCategory = COM.AcctCategory and ACT.Project = Com.Project and ACT.PerYear = COM.PerYear) A FULL OUTER JOIN
(SELECT        	pjptdrol.project AS Project, 
				RTRIM(dbo.PJPTDROL.acct) AS AcctCategory, 
                rtrim(pjacct.acct_type) AS AcctType, 
					dbo.PJPTDROL.eac_amount AS EACAmt, 
					dbo.PJPTDROL.eac_units AS EACUnits, 
                    dbo.PJPTDROL.total_budget_amount AS OriginalBudgetAmt,
					dbo.PJPTDROL.total_budget_units AS OriginalBudgetUntis
                FROM            pjptdrol JOIN
                                pjacct ON pjptdrol.acct = pjacct.acct
                WHERE			(pjacct.acct_type = 'RV' OR
									pjacct.acct_type = 'EX')) B ON A.AcctCategory = B.AcctCategory and A.Project = B.Project) PNP
)
