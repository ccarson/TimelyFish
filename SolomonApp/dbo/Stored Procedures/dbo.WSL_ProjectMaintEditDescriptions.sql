
CREATE PROCEDURE [dbo].[WSL_ProjectMaintEditDescriptions]
@page  int -- ignored.  here for patttern
,@size  int -- ignored.  here for patttern
,@sort   nvarchar(200) -- ignored.  here for patttern
 ,@parm1 varchar (16) -- Project   Required.  no wildcards expected.
AS
  SET NOCOUNT ON

	select  isnull(pj.[customer name],'') [CustomerName],
			isnull(sp.[Name],'') [SalespersonName],
			isnull(pj.[project mgr name],'') [ProjectMgrName],
			isnull(pj.[business mgr name],'') [BusinessMgrName],
			c.CpnyName,
			s.Descr [SubacctDesc],
			isnull(ct.contract_desc,'') [ContractDesc],
			isnull(cd1.code_value_desc,'') [ContractTypeDesc]
	from QQ_pjprojNamed  as pj  (nolock)
	LEFT outer join Salesperson as sp (nolock) on sp.SlsperId = pj.salesperson
	LEFT Outer Join vs_company as c  (nolock) on c.CpnyID = pj.company
	LEFT Outer Join SubAcct as s (nolock) on s.Sub = pj.subaccount
	LEFT Outer Join pjcont as ct (nolock) on ct.[contract] = pj.[contract]
	LEFT outer Join pjcode as cd1 (nolock) on cd1.code_type = 'CONT' and cd1.code_value = pj.[contract type] 
	where pj.project = @parm1

