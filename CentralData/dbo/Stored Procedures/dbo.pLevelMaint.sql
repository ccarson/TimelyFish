--Created by: Charity Gaborik
--Created Date: 4/8/2003
--Queries a specific set of Level descriptions and precedence
--by passing the ParentID of the ParentPhase and the EffectiveDate
--Used in BioSecurity Maintenance App as the recordsource for the Maintenance recordset
--where the ComponentType is level (all other component types use pComponentMaint)
Create Procedure dbo.pLevelMaint
	@Parent varchar(5),
	@EffectiveDate smalldatetime
	
AS

Select ppbl.EffectiveDate,ppbl.ProductionPhaseBioSecurityLevelID as ID, ppbl.Description,ppbl.Precedence,'' as ComponentType,
	ppbl.ProductionTypeProductionPhaseID as ParentID
FROM ProductionPhaseBioSecurityLevel ppbl
JOIN (Select Max(EffectiveDate) as EffectiveDate, ProductionPhaseBioSecurityLevelID as ID
	FROM ProductionPhaseBioSecurityLevel
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY ProductionPhaseBioSecurityLevelID) dppbl --derived table of distinct levels
ON ppbl.EffectiveDate=dppbl.EffectiveDate
AND ppbl.ProductionPhaseBioSecurityLevelID=dppbl.ID
where ppbl.ProductionTypeProductionPhaseID=@Parent

