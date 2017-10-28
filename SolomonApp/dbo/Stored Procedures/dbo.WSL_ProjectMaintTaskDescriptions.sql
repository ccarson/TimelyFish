
CREATE PROCEDURE [dbo].[WSL_ProjectMaintTaskDescriptions]
@page  int -- ignored.  here for patttern
,@size  int -- ignored.  here for patttern
,@sort   nvarchar(200) -- ignored.  here for patttern
 ,@parm1 varchar (16) -- Project   Required.  no wildcards expected.
 ,@parm2 varchar (10) -- Task   Required.  no wildcards expected.
AS
  SET NOCOUNT ON

	select  isnull(ct.code_value_desc,'') [ContractTypeDesc],
			isnull(pe.emp_name,'') [ManagerName],
			isnull(st1.Descr,'') [Tax1Desc],
			isnull(st2.Descr,'') [Tax2Desc],
			isnull(st3.Descr,'') [Tax3Desc],
			isnull(s.Descr,'') [GLSubAcctDesc],
			isnull(et.code_value_desc,'') [EarningTypeDesc],
			isnull(up.code_value_desc,'') [UnitsOfProductionDesc],
			isnull(wl.code_value_desc,'') [WorkLocationDesc],
			isnull(wc.code_value_desc,'') [WorkCompCodeDesc],
			isnull(la.Descr,'') [LaborAccountDesc]
	from PJvTask  as pt  (nolock)
	LEFT outer join PJCODE as ct (nolock) on ct.code_value = pt.contract_type AND ct.code_type = 'CONT'
	LEFT outer join PJEmploy as pe (nolock) on pe.employee = pt.manager1
	LEFT outer join SalesTax as st1 (nolock) on st1.TaxId = pt.fips_num
	LEFT outer join SalesTax as st2 (nolock) on st2.TaxId = pt.pe_id35
	LEFT outer join SalesTax as st3 (nolock) on st3.TaxId = pt.pe_id36
	LEFT Outer Join SubAcct as s (nolock) on s.Sub = pt.pe_id01
	LEFT outer join PJCODE as et (nolock) on et.code_value = pt.pe_id03 AND et.code_type = 'EARN'
	LEFT outer join PJCODE as up (nolock) on up.code_value = pt.pe_id05 AND up.code_type = '0UOM'
	LEFT outer join PJCODE as wl(nolock) on wl.code_value = pt.PE_ID13 AND wl.code_type = 'WLOC'
	LEFT outer join PJCODE as wc(nolock) on wc.code_value = pt.PE_ID14 AND wc.code_type = 'WKCC'
	LEFT outer join Account as la (nolock) on la.Acct = pt.PE_ID23
	where pt.project = @parm1 and pt.pjt_entity = @parm2

