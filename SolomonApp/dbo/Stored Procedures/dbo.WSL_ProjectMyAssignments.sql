
CREATE PROCEDURE [dbo].[WSL_ProjectMyAssignments]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee
 ,@parm2 smalldatetime -- Start Date
 ,@parm3 smalldatetime -- End Date
 ,@parm4 varchar (2) -- Timecard Type
AS
  SET NOCOUNT ON
  DECLARE
	@STMT nvarchar(max), 
	@lbound int,
	@ubound int
	  
  IF @page = 0  -- Don't do paging
	BEGIN
		SET @page = 1
		SET @size = 20
	END
  ELSE
	BEGIN
		IF @page < 1 SET @page = 1
		IF @size < 1 SET @size = 1
	END
  BEGIN
		IF @sort = '' SET @sort = 'proj.project'
		SET @lbound = (@page-1) * @size
		SET @ubound = @page * @size + 1

		BEGIN
		  CREATE TABLE #myAssignments
			(
				Project char(16),
				project_desc char(60),
				pjt_entity char(32),
				pjt_entity_desc char(60),
				SubTask_Name char(50),
				Company char(10),
				DocNbr char(10),
				LineNbr smallint,
				Account char(10),
				Subaccount char(24),
				LaborClass char(4),
				CertPrFlag int,
				ManagerReviewStatus char(4),
				[Shift] char(7),
				PrevailingWageGroup char(16),
				[Union] char(10),
				WorkersComp char(6),
				WorkType char(2),
				IsAssignment int,
				MyTotal float,
				PeriodTotal float,
				TaskTotal float,
				EstHours float,
				ProjCustomer char(15),
				customer_desc char(60)
			)

			Insert into #myAssignments
					SELECT proj.[Project] 
						,proj.[project_desc]
						,pentem.[Pjt_entity]
						,pent.[pjt_entity_desc]
						,pentem.[SubTask_Name]
						,labdet.CpnyId_chrg AS Company
						,MAX(labdet.docnbr) AS DocNbr
						,MIN(labdet.linenbr) As LineNbr
						,labdet.gl_acct AS Account
						,labdet.gl_subacct AS Subaccount
						,labdet.labor_class_cd AS LaborClass
						,labdet.ld_id10 AS CertPrFlag
						,MAX(labdet.ld_id17) AS ManagerReviewStatus
						,labdet.[shift] AS [Shift]
						,labdet.ld_id03 AS PrevailingWageGroup
						,labdet.union_cd AS [Union]
						,labdet.work_comp_cd AS WorkersComp
						,labdet.work_type AS WorkType
						,1 AS IsAssignment
						,ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = pentem.Pjt_entity AND p.SubTask_Name = pentem.SubTask_Name AND h.employee = pentem.Employee
								AND (h.le_type <> 'C' OR (h.le_type = 'C' and h.le_status = 'P')) AND h.le_status <> 'X'
						), 0) AS MyTotal
						,ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = pentem.Pjt_entity AND p.SubTask_Name = pentem.SubTask_Name AND h.employee = pentem.Employee
								AND (h.le_type = @parm4 OR (h.le_type <> @parm4 and h.le_status = 'P')) AND h.le_status <> 'X' AND (pentem.Date_start <= @parm3 AND pentem.Date_end >= @parm2)
								AND ((h.le_id01 = 'Y' AND p.ld_id08 >= @parm2 AND p.ld_id08 <= @parm3) OR (h.le_id01 <> 'Y' AND h.pe_date >= @parm2 AND h.pe_date <= @parm3)) AND h.le_type = @parm4
						), 0) AS PeriodTotal
						,ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = pentem.Pjt_entity AND p.SubTask_Name = pentem.SubTask_Name
								AND (h.le_type <> 'C' OR (h.le_type = 'C' and h.le_status = 'P')) AND h.le_status <> 'X'
						), 0) AS TaskTotal
						,ISNULL((
							SELECT SUM(budget_units)
							FROM [PJPENTEM] p
							WHERE p.project = proj.Project AND p.pjt_entity = pentem.Pjt_entity AND p.SubTask_Name = pentem.SubTask_Name AND p.employee = pentem.Employee
						), 0) AS EstHours
						, proj.customer as ProjCustomer
						, customer.Name as customer_desc

						from [PJPENTEM] pentem (nolock)

							INNER JOIN [PJPROJEM] projem (nolock)
							ON pentem.Project = projem.project

							INNER JOIN [PJPENT] pent (nolock)
							ON pentem.Project = pent.Project and pentem.PJT_Entity = pent.PJT_Entity

							INNER JOIN [PJPROJ] proj (nolock)
							ON pentem.Project = proj.Project

							LEFT OUTER JOIN [CUSTOMER] (nolock)
							ON [CUSTOMER].CustId = proj.customer

									LEFT OUTER JOIN [PJLABDET] labdet (nolock)
										INNER JOIN [PJLABHDR] labhdr (nolock)
										ON labhdr.docnbr = labdet.docnbr 
											AND ((labhdr.le_id01 = 'Y' AND labdet.ld_id08 >= @parm2 AND labdet.ld_id08 <= @parm3) OR (labhdr.le_id01 <> 'Y' AND labhdr.pe_date >= @parm2 AND labhdr.pe_date <= @parm3))
											AND labhdr.employee = @parm1 AND labhdr.le_type = @parm4

									ON labdet.project = pent.project 
									   AND labdet.pjt_entity = pent.pjt_entity
									   AND labdet.SubTask_Name = pentem.SubTask_Name

					where pentem.Employee like @parm1
							AND (pentem.Date_start <= @parm3 AND pentem.Date_end >= @parm2)
							AND (projem.employee like @parm1 OR projem.employee = '*')
					GROUP BY
						pentem.[Employee]
						,proj.[Project]
						,proj.[project_desc]
						,pentem.[Pjt_entity]
						,pent.[pjt_entity_desc]
						,pentem.[SubTask_Name]
						,labdet.CpnyId_chrg
						,labdet.gl_acct
						,labdet.gl_subacct
						,labdet.labor_class_cd
						,labdet.ld_id10
						,labdet.[shift]
						,labdet.ld_id03
						,labdet.union_cd
						,labdet.work_comp_cd
						,labdet.work_type
						,pentem.Date_start
						,pentem.Date_end
						,proj.customer
						,customer.Name

				UNION ALL

					SELECT
						proj.project,
						proj.project_desc,
						labdet.pjt_entity,
						pent.pjt_entity_desc,
						labdet.SubTask_Name,
						labdet.CpnyId_chrg AS Company,
						MAX(labhdr.docnbr) AS DocNbr,
						MIN(labdet.linenbr) As LineNbr,
						labdet.gl_acct AS Account,
						labdet.gl_subacct AS Subaccount,
						labdet.labor_class_cd AS LaborClass,
						labdet.ld_id10 AS CertPrFlag,
						MAX(labdet.ld_id17) AS ManagerReviewStatus,
						labdet.[shift] AS [Shift],
						labdet.ld_id03 AS PrevailingWageGroup,
						labdet.union_cd AS [Union],
						labdet.work_comp_cd AS WorkersComp,
						labdet.work_type AS WorkType,
						0 AS IsAssignment,
						ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = labdet.Pjt_entity AND p.SubTask_Name = labdet.SubTask_Name AND h.employee = labhdr.Employee
								AND p.CpnyId_chrg = labdet.CpnyId_chrg AND p.gl_acct = labdet.gl_acct AND p.gl_subacct = labdet.gl_subacct AND p.shift = labdet.shift
								AND p.labor_class_cd = labdet.labor_class_cd AND p.ld_id03 = labdet.ld_id03 AND p.union_cd = labdet.union_cd
								AND p.work_comp_cd = labdet.work_comp_cd AND p.work_type = labdet.work_type
								AND (h.le_type <> 'C' OR (h.le_type = 'C' and h.le_status = 'P')) AND h.le_status <> 'X'
						), 0) AS MyTotal,
						ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = labdet.Pjt_entity AND p.SubTask_Name = labdet.SubTask_Name AND h.employee = labhdr.Employee
								AND p.CpnyId_chrg = labdet.CpnyId_chrg AND p.gl_acct = labdet.gl_acct AND p.gl_subacct = labdet.gl_subacct AND p.shift = labdet.shift
								AND p.labor_class_cd = labdet.labor_class_cd AND p.ld_id03 = labdet.ld_id03 AND p.union_cd = labdet.union_cd
								AND p.work_comp_cd = labdet.work_comp_cd AND p.work_type = labdet.work_type
								AND (h.le_type = @parm4 OR (h.le_type <> @parm4 and h.le_status = 'P')) AND h.le_status <> 'X'
								AND ((h.le_id01 = 'Y' AND p.ld_id08 >= @parm2 AND p.ld_id08 <= @parm3) OR (h.le_id01 <> 'Y' AND h.pe_date >= @parm2 AND h.pe_date <= @parm3)) AND h.le_type = @parm4
						), 0) AS PeriodTotal,
						ISNULL((
							SELECT SUM(p.day1_hr1) + SUM(p.day1_hr2) + SUM(p.day1_hr3) +
								SUM(p.day2_hr1) + SUM(p.day2_hr2) + SUM(p.day2_hr3) +
								SUM(p.day3_hr1) + SUM(p.day3_hr2) + SUM(p.day3_hr3) +
								SUM(p.day4_hr1) + SUM(p.day4_hr2) + SUM(p.day4_hr3) +
								SUM(p.day5_hr1) + SUM(p.day5_hr2) + SUM(p.day5_hr3) +
								SUM(p.day6_hr1) + SUM(p.day6_hr2) + SUM(p.day6_hr3) +
								SUM(p.day7_hr1) + SUM(p.day7_hr2) + SUM(p.day7_hr3)
							FROM [PJLABDET] p INNER JOIN [PJLABHDR] h ON p.docnbr = h.docnbr
							WHERE p.project = proj.Project AND p.pjt_entity = labdet.Pjt_entity AND p.SubTask_Name = labdet.SubTask_Name
								AND p.CpnyId_chrg = labdet.CpnyId_chrg AND p.gl_acct = labdet.gl_acct AND p.gl_subacct = labdet.gl_subacct
								AND p.labor_class_cd = labdet.labor_class_cd AND p.ld_id03 = labdet.ld_id03 AND p.union_cd = labdet.union_cd
								AND p.work_comp_cd = labdet.work_comp_cd AND p.work_type = labdet.work_type
								AND (h.le_type <> 'C' OR (h.le_type = 'C' and h.le_status = 'P')) AND h.le_status <> 'X'
						), 0) AS TaskTotal,
						ISNULL((
							SELECT SUM(budget_units)
							FROM [PJPENTEM] p
							WHERE p.project = proj.Project AND p.pjt_entity = labdet.Pjt_entity AND p.SubTask_Name = labdet.SubTask_Name AND p.employee = labhdr.Employee
						), 0) AS EstHours
						, proj.customer as ProjCustomer
						, customer.Name as customer_desc

					FROM [PJLABHDR] labhdr (nolock)
						INNER JOIN [PJLABDET] labdet (nolock)
							ON labhdr.docnbr = labdet.docnbr 
								AND ((labhdr.le_id01 = 'Y' AND labdet.ld_id08 >= @parm2 AND labdet.ld_id08 <= @parm3) OR (labhdr.le_id01 <> 'Y' AND labhdr.pe_date >= @parm2 AND labhdr.pe_date <= @parm3))
								AND labhdr.employee = @parm1 and labhdr.le_type = @parm4
						INNER JOIN [PJPROJ] proj (nolock)
							ON proj.project = labdet.project 
						INNER JOIN [PJPENT] pent (nolock)
							ON pent.project = proj.project AND pent.pjt_entity = labdet.Pjt_entity
							LEFT OUTER JOIN [CUSTOMER] (nolock)
							ON [CUSTOMER].CustId = proj.customer
			
					WHERE 
						NOT EXISTS
						(
							SELECT *
							FROM [PJPENTEM]
							WHERE [PJPENTEM].employee = @parm1
								AND [PJPENTEM].Project = labdet.project
								AND [PJPENTEM].Pjt_entity = labdet.pjt_entity
								AND [PJPENTEM].SubTask_Name = labdet.SubTask_Name
								AND [PJPENTEM].Date_start <= @parm3
								AND [PJPENTEM].Date_end >= @parm2
						)

					GROUP BY
						labhdr.[Employee]
						,proj.[Project]
						,proj.[project_desc]
						,labdet.[Pjt_entity]
						,pent.[pjt_entity_desc]
						,labdet.[SubTask_Name]
						,labdet.CpnyId_chrg
						,labdet.gl_acct
						,labdet.gl_subacct
						,labdet.labor_class_cd
						,labdet.ld_id10
						,labdet.[shift]
						,labdet.ld_id03
						,labdet.union_cd
						,labdet.work_comp_cd
						,labdet.work_type
						,proj.customer
						,customer.Name;


			With PagingCTE As (
				select TOP( @ubound - 1) Project, project_desc, pjt_entity, pjt_entity_desc, SubTask_Name,
					Company, DocNbr, LineNbr, Account, Subaccount, LaborClass, CertPrFlag,
					ManagerReviewStatus, [Shift], PrevailingWageGroup, [Union], WorkersComp,
					WorkType, IsAssignment, MyTotal, PeriodTotal, TaskTotal, EstHours, ProjCustomer, customer_desc, ROW_NUMBER() OVER(ORDER BY @sort) as row from #myAssignments
			)

					SELECT TOP( @ubound-1) [Project]
						,[project_desc]
						,[Pjt_entity]
						,[pjt_entity_desc]
						,[SubTask_Name]
						,Company
						,DocNbr
						,LineNbr
						,Account
						,Subaccount
						,LaborClass
						,CertPrFlag
						,ManagerReviewStatus
						,[Shift]
						,PrevailingWageGroup
						,[Union]
						,WorkersComp
						,WorkType
						,IsAssignment
						,MyTotal
						,PeriodTotal
						,TaskTotal
						,EstHours
						,ProjCustomer
						,customer_desc
					FROM PagingCTE                     
					WHERE  row > @lbound AND
							row < @ubound
					ORDER BY row

			END
	  END				
	  drop table #myAssignments


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMyAssignments] TO [MSDSL]
    AS [dbo];

