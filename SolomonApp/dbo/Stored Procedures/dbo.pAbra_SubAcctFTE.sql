CREATE proc pAbra_SubAcctFTE (@parm1 as smalldatetime, @parm2 as smalldatetime)
AS

CREATE TABLE #tAbra_HrJobCst
(ChargeDate  smalldatetime, EmpNo varchar(30), CpnyID varchar(10), SubAmount Decimal(10,3), 
SubAcct varchar(30))

INSERT INTO #tAbra_HrJobCst
select ChargeDate, Empno,company,amount,rtrim(orglevel1) + rtrim(orglevel2) + left(orglevel3,4)
	FROM OPENQUERY(ABRADATA,'Select * from prJobCst')


CREATE TABLE #tAbra_Employee_FullEmpNo
(EmpNo varchar(30),  subacct  varchar(30),CpnyID  varchar(10),
	 FTE Decimal(10,1), TermDate datetime)

INSERT INTO #tAbra_Employee_FullEmpNo
SELECT p_EmpNo, rtrim(p_level1)+ rtrim(p_level2) + left(p_level3,4),
p_Company, Case when p_Employ in ('FT','TF') then 1 else .5 end, p_TermDate
	from OPENQUERY(ABRADATA,'Select * from HRPersnl')
	where p_TermDate not between @parm1 and @parm2
	 
CREATE TABLE #tAbra_Employee_JobCost
(EmpNo varchar(30), FTE Decimal(10,1), 
	SubAmount Decimal(10,3), SubAcct varchar(30),CpnyID  varchar(3))
Select ChargeDate,jc.EmpNo,FTE,
sum(jc.SubAmount) as SubAmount,jc.subacct,jc.CpnyID,TermDate
from #tAbra_Employee_FullEmpNo e
JOIN #tAbra_HrJobCst jc on e.EmpNo=jc.EmpNo
where jc.subacct in (Select sub from subacct)
	and ChargeDate between @parm1 and @parm2 
	and e.TermDate not between @parm1 and @parm2
Group by jc.EmpNo,FTE,jc.subacct,jc.ChargeDate,jc.CpnyID, TermDate

Select * from #tAbra_Employee_JobCost 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pAbra_SubAcctFTE] TO [MSDSL]
    AS [dbo];

