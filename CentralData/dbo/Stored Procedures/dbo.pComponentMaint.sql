--Created by: Charity Gaborik
--Created Date: 4/7/2003
--Queries a specific set of BioSecurity Component descriptions and precedence
--by passing the Component Type and the EffectiveDate
--Used in BioSecurity Maintenance App as the recordsource for the Maintenance recordset
--where the ComponentType is not level (level uses pLevelMaint)
Create Procedure dbo.pComponentMaint
	@EffectiveDate smalldatetime,
	@CompType varchar(10)
AS

SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence, bc.ComponentType,0 as ParentID
FROM BioSecurityComponent bc
JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
	FROM BioSecurityComponent 
	WHERE EffectiveDate<=@EffectiveDate
	AND ComponentType=@CompType
	GROUP BY ID) dbc --derived table distinct components
ON bc.EffectiveDate=dbc.EffectiveDate
AND bc.ID=dbc.ID
WHERE bc.ComponentType=@CompType

