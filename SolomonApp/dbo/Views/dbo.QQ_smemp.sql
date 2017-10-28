
CREATE VIEW [QQ_smemp]
AS
SELECT     CpnyID AS [Company ID], EmployeeId AS [Service Employee ID], EmployeeActive AS [Active Employee], EmployeeLastName AS [Last Name], 
                      EmployeeFirstName AS [First Name], EmployeeMiddleInit AS [Middle Initial], employeeaddress1 AS [Address Line 1], employeeaddress2 AS [Address Line 2], 
                      EmployeeCity AS City, EmployeeState AS State, EmployeeZip AS [Zip/Postal Code],'***-**-' + (SUBSTRING(EmployeeSSNo, 6, 4)) As [Social Security Number], convert(date,employeeBdate) AS Birthdate, 
                      '(' + SUBSTRING(EmployeeHomePhone, 1, 3) + ')' + SUBSTRING(EmployeeHomePhone, 4, 3) + '-' + RTRIM(SUBSTRING(EmployeeHomePhone, 7, 24)) AS [Home Phone],
                      '(' + SUBSTRING(EmployeeCellPhone, 1, 3) + ')' + SUBSTRING(EmployeeCellPhone, 4, 3) + '-' + RTRIM(SUBSTRING(EmployeeCellPhone, 7, 24)) AS [Cellular Phone],
                      '(' + SUBSTRING(EmployeePagerNo, 1, 3) + ')' + SUBSTRING(EmployeePagerNo, 4, 3) + '-' + RTRIM(SUBSTRING(EmployeePagerNo, 7, 24)) AS [Pager Number],
                      TemplateID, Supervisor, 
                      EmployeeOffPhoneExt AS [Office Phone Extension], EmployeePayRollId AS [Payroll ID], WorkersComp AS [Worker's Comp Code], EmployeeSex AS Sex, 
                      EmployeeMarital AS [Marital Status], EmployeeExemption AS Exemptions, EmployeeDLNo AS [Driver's License Number], 
                      convert(date,employeeDLExpDate) AS [License Expiration Date], EmployeeDLState AS [License Issuing State], EmployeeDLClass AS [License Class/Endorsements], 
                      EmployeeVehicleId AS [Vehicle ID], EmployeePayType AS [Pay Type], EmployeeDept AS [Department ID], EmployeeRate AS [Pay Rate], 
                      convert(date,EmployeeHiredate) AS [Date Hired], convert(date,EmployeeRaiseDate) AS [Date of Last Raise], convert(date,EmployeeTermDate) AS [Date Terminated], 
                      EmployeeCommPlan AS [Commission Plan ID], EmployeeQuota AS [Sales Quota], Cetrtified AS Certified, CommLaborPct AS [Commission Labor Percent], 
                      CommMaterialPct AS [Commission Material Percent], convert(date,Crtd_DateTime) AS [Create Date], Crtd_Prog AS [Create Program], Crtd_User AS [Create User], 
                      EarnType AS [Payroll Earnings Type], EmailAddr AS [Email Address], EmployeeBranchID, EmployeeFaxNo AS [Fax Number], EmployeeType AS [Employee Class], 
                      EmployeeWorkerDept AS [Worker's Comp Department], InvtSiteID AS [Inventory Site ID], LaborClass, convert(date,Lupd_DateTime) AS [Last Update Date], 
                      Lupd_Prog AS [Last Update Program], Lupd_User AS [Last Update User], NoteID, OvhdFringe AS [Overhead Fringe], OvhdFringeType AS [Overhead Fringe Type], 
                      OvhdInsur AS [Overhead Insurance], OvhdInsurType AS [Overhead Insurance Type], OvhdOther AS [Overhead Other], OvhdOtherType AS [Overhead Other Type], 
                      OvhdTaxes AS [Overhead Taxes], OvhdTaxesType AS [Overhead Taxes Type], ShiftCode, TimeZone, UnionCode, User1, User2, User3, User4, User5, User6, 
                      convert(date,User7) AS [User7], convert(date,User8) AS [User8], WageCode, WageGroup, WorkLoc AS [Work Location], WorkType
FROM         smEmp WITH (nolock)

