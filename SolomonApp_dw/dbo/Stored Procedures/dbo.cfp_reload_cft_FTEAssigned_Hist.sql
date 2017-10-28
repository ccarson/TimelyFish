







create PROCEDURE [dbo].[cfp_reload_cft_FTEAssigned_Hist]
AS
BEGIN


--clear table for new data
truncate table  dbo.cft_FTEAssigned_Hist

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
insert into cft_FTEAssigned_Hist
([PersonIdNo]
      ,[FirstName]
      ,[LastName]
      ,[PositionFromEffectDate]
      ,[PositionToEffectDate]
      ,[PositionIdNo]
      ,[PositionCode]
      ,[SeniorityDate]
      ,[EmploymentCode]
      ,[TerminationDate]
      ,[PositionReason]
      ,[TermType]
      ,[AssignedFTE]
      ,[OrgCodeIdNo]
      ,[Company]
      ,[DivisionCode]
      ,[DepartmentCode]
      ,[LocationCode])
SELECT DISTINCT
	vPersons.PersonIdNo,
	vPersons.FirstName,
	vPersons.LastName,
	vPerson_Positions.PositionFromEffectDate, 
	vPerson_Positions.PositionToEffectDate, 
	vPerson_Positions.PositionIdNo, 
	vPOSITION_CODES.PositionCode,
	vEmployment_Status.SeniorityDate,
	vEmployment_Codes.EmploymentCode,
	vEmployment_Status.TerminationDate,
	vPerson_Positions.PositionReason,
	TermCodes.PersonCode AS TermType,
	fteamt.FTEAmount AS AssignedFTE,
	rco.OrgCodeIdNo,
	RTRIM(rco.OrganizationCode) 'Company',
	LEFT(div.OrganizationDescription,2) 'DivisionCode',
	LEFT(ruo.OrganizationDescription,2) 'DepartmentCode',
	rlo.OrganizationCode 'LocationCode'
FROM vPerson_Positions vPerson_Positions
LEFT JOIN vPersons vPersons
	ON vPersons.PersonIdNo = vPerson_Positions.PersonIdNo
LEFT JOIN vEmployment_Status vEmployment_Status
	ON vEmployment_Status.PersonIdNo = vPerson_Positions.PersonIdNo
LEFT JOIN vEmployment_Codes vEmployment_Codes
	ON vEmployment_Codes.EmploymentCodeIdNo = vEmployment_Status.EmploymentStatus
LEFT JOIN dbo.tsy_person_codes TermCodes (NOLOCK)
	ON TermCodes.PersonCodeIdNo = vEmployment_Status.TerminationTypeIdNo
LEFT JOIN vPOSITION_CODES vPOSITION_CODES
	ON vPOSITION_CODES.PositionIdNo = vPerson_Positions.PositionIdNo 
	OR vPOSITION_CODES.PositionIdNo IS NULL
LEFT JOIN dbo.tFTE_DEFINITION_CODE_VALUES fteamt (NOLOCK)
	ON vPOSITION_CODES.FTEDefinitionIdNo = fteamt.FTEDefinitionIdNo
LEFT JOIN ReportCompanySue rco 
	ON vPOSITION_CODES.PositionIdNo = rco.PositionIdNo
LEFT JOIN ReportUpperOrg ruo 
	ON vPOSITION_CODES.PositionIdNo = ruo.PositionIdNo
LEFT JOIN ReportLowerOrg rlo 
	ON vPOSITION_CODES.PositionIdNo = rlo.PositionIdNo
LEFT OUTER JOIN   dbo.FuncDivision_Curr div
	ON div.PositionIdNo = vPerson_Positions.PositionIdNo  
WHERE vPerson_Positions.PositionToEffectDate BETWEEN vPersons.PersonFromEffectDate AND vPersons.PersonToEffectDate
AND vPerson_Positions.PositionToEffectDate BETWEEN vEmployment_Status.EmploymentStatusFromEffectDate AND vEmployment_Status.EmploymentStatusToEffectDate
AND vPerson_Positions.PositionToEffectDate BETWEEN vEmployment_Codes.EmploymentCodeFromEffectDate AND vEmployment_Codes.EmploymentCodeToEffectDate
AND vPerson_Positions.PositionToEffectDate BETWEEN vPOSITION_CODES.PositionCodeFromEffectDate AND vPOSITION_CODES.PositionCodeToEffectDate
AND ((vPerson_Positions.PositionToEffectDate BETWEEN rco.PositionOrgFromEffectDate AND rco.PositionOrgToEffectDate)
    OR rco.PositionIdNo IS NULL)
    AND ((vPerson_Positions.PositionToEffectDate BETWEEN rco.OrganizationFromEffectDate AND rco.OrganizationToEffectDate)
    OR rco.PositionIdNo IS NULL)
AND ((vPerson_Positions.PositionToEffectDate BETWEEN ruo.PositionOrgFromEffectDate AND ruo.PositionOrgToEffectDate)
    OR ruo.PositionIdNo IS NULL)
    AND ((vPerson_Positions.PositionToEffectDate BETWEEN ruo.OrganizationFromEffectDate AND ruo.OrganizationToEffectDate)
    OR ruo.PositionIdNo IS NULL)
AND ((vPerson_Positions.PositionToEffectDate BETWEEN rlo.PositionOrgFromEffectDate AND rlo.PositionOrgToEffectDate)
    OR rlo.PositionIdNo IS NULL)
    AND ((vPerson_Positions.PositionToEffectDate BETWEEN rlo.OrganizationFromEffectDate AND rlo.OrganizationToEffectDate)
    OR rlo.PositionIdNo IS NULL)
AND vEmployment_Status.OrgCodeIdNo = rco.OrgCodeIdNo
AND vPerson_Positions.PositionPrimaryInd = 1
/* and rlo.OrganizationCode not in ('loc7400', 'loc6970','loc0266','loc2280','loc3100','loc3150')

	as per user request, removing sites 20120904 SRIPLEY  (20130822 as requested by Janice Millard this filter is to be rolled  back)
		N5		LOC7400
		F48		LOC6970
		N16		LOC0266
		KUBESH	LOC2280
		BAARSCH	LOC3100 & LOC3150
*/


END







