
CREATE PROCEDURE [dbo].[WSL_ProjectMaintAccountDescriptions]
@page  int -- ignored.  here for patttern
,@size  int -- ignored.  here for patttern
,@sort   nvarchar(200) -- ignored.  here for patttern
 ,@parm1 varchar (16) -- Project   Required.  no wildcards expected.
AS
  SET NOCOUNT ON

	select  isnull(am1.code_value_desc,'') [AllocationMethodDesc1],
			isnull(am2.code_value_desc,'') [AllocationMethodDesc2],
			isnull(rt1.code_value_desc,'') [RateTableDesc1],
			isnull(la.Descr,'') [LaborAccountDesc],
			isnull(rt2.code_value_desc,'') [RateTableDesc2],
			isnull(cc.code_value_desc,'') [CurrencyDesc],
			isnull(bc.Descr,'') [BillCurrencyDesc],
			isnull(cr.Descr,'') [BillingCurrencyRateTypeDesc],
			isnull(et.code_value_desc,'') [EarningsTypeDesc],
			isnull(pw.code_value_desc,'') [PrevailingWageDesc],
			isnull(wl.code_value_desc,'') [WorkLocationDesc],
			isnull(wc.code_value_desc,'') [WorkCompCodeDesc],
			isnull(br.code_value_desc,'') [BillingRuleDesc],
			isnull(rb.code_value_desc,'') [RevenueBudgetRateTypeDesc]
	from PJvProject  as pj  (nolock)
	LEFT outer join PJBILL (nolock) on PJBILL.project = pj.project
	LEFT outer join PJCODE as am1 (nolock) on am1.code_value = pj.alloc_method_cd AND am1.code_type = 'ALLM'
	LEFT outer join PJCODE as am2 (nolock) on am2.code_value = pj.alloc_method2_cd AND am2.code_type = 'ALLM'
	LEFT outer join PJCODE as rt1 (nolock) on rt1.code_value = pj.rate_table_id AND rt1.code_type = 'RTAB'
	LEFT outer join Account as la (nolock) on la.Acct = pj.labor_gl_acct
	LEFT outer join PJCODE as rt2 (nolock) on rt2.code_value = pj.rate_table_labor AND rt2.code_type = 'RTAB'
	LEFT outer join PJCODE as cc (nolock) on cc.code_value = pj.CuryId AND cc.code_type = 'CURR'
	LEFT outer join Currncy as bc (nolock) on bc.CuryId = pj.billcuryid 
	LEFT outer join CuryRtTp as cr (nolock) on cr.RateTypeId = pj.billratetypeid 
	LEFT outer join PJCODE as et (nolock) on et.code_value = pj.PM_ID14 AND et.code_type = 'EARN'
	LEFT outer join PJCODE as pw (nolock) on pw.code_value = pj.PM_ID15 AND pw.code_type = 'PWAG'
	LEFT outer join PJCODE as wl(nolock) on wl.code_value = pj.work_location AND wl.code_type = 'WLOC'
	LEFT outer join PJCODE as wc(nolock) on wc.code_value = pj.work_comp_cd AND wc.code_type = 'WKCC'
	LEFT outer join PJCODE as br(nolock) on br.code_value = PJBILL.bill_type_cd AND br.code_type = 'BRUL'
	LEFT outer join PJCODE as rb(nolock) on rb.code_value = pj.budget_version AND rb.code_type = 'RATE'
	where pj.project = @parm1

