--Created by: Charity Gaborik
--Created Date: 4/9/2003
--Creates a recordset of all Parents with corresponding child nodes
--Used in BioSecurity app as the recordsource for the TreeView control
--Effective date is passed in to filter the records for a specific date
--Parent and Node IDs are formatted as ParentID<ComponentType>NodeID
Create Procedure dbo.pTreeView
	@EffectiveDate smalldatetime
AS
Declare @CompType varchar(3)
Declare @CompType1 varchar(3)
Declare @CompType2 varchar(3)

Select @CompType='sys' --System
Select @CompType1='typ' --Type
Select @CompType2='pha' --Phase

Select Distinct '<bio>0' as ParentID, '0<sys>' + convert(varchar(5),bs.BioSecuritySystemID) as NodeID, dsys.Description as Node,dsys.Precedence, 1 as RootLevel
FROM BioSecuritySystem bs
JOIN (Select Max(EffectiveDate) as EffectiveDate, BioSecuritySystemID
	FROM BioSecuritySystem
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY BioSecuritySystemID) dbio --derived table of distinct assigned systems
ON dbio.BioSecuritySystemID=bs.BioSecuritySystemID
AND dbio.EffectiveDate=bs.EffectiveDate
JOIN  
( SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
FROM BioSecurityComponent bc
JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
	FROM BioSecurityComponent 
	WHERE EffectiveDate<=@EffectiveDate
	AND ComponentType=@CompType
	GROUP BY ID) dbc --derived table of systemIDs for EffectiveDate
ON bc.EffectiveDate=dbc.EffectiveDate
AND bc.ID=dbc.ID
WHERE bc.ComponentType=@CompType)dsys --derived table for system descriptions and precedence
ON bs.PigSystemID=dsys.ID
Where bs.BioSecurityID is not null

Union

Select Distinct '0<sys>' + convert(varchar(5),spt.BioSecuritySystemID) as ParentID, 
	convert(varchar(5),spt.BioSecuritySystemID) + '<typ>' + convert(varchar(5),spt.SystemProductionTypeID) as NodeID, dsys.Description as Node,dsys.Precedence, 2 as RootLevel
FROM SystemProductionType spt
JOIN (Select Max(EffectiveDate) as EffectiveDate, SystemProductionTypeID
	FROM SystemProductionType
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY SystemProductionTypeID) dtyp--derived table of distinct assigned ProductionTypes
ON dtyp.SystemProductionTypeID=spt.SystemProductionTypeID
AND dtyp.EffectiveDate=spt.EffectiveDate
JOIN  
( SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
FROM BioSecurityComponent bc
JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
	FROM BioSecurityComponent 
	WHERE EffectiveDate<=@EffectiveDate
	AND ComponentType=@CompType1
	GROUP BY ID) dbc--derived table of TypeIDs for EffectiveDate
ON bc.EffectiveDate=dbc.EffectiveDate
AND bc.ID=dbc.ID
WHERE bc.ComponentType=@CompType1)dsys--derived table for type descriptions and precedence
ON spt.PigProductionTypeID=dsys.ID
Where spt.BioSecuritySystemID is not null

Union

Select Distinct convert(varchar(5),spt.BioSecuritySystemID)+ '<typ>' + convert(varchar(5),pppt.SystemProductionTypeID) as ParentID, 
	convert(varchar(5),pppt.SystemProductionTypeID) + '<pha>' + convert(varchar(5),pppt.ProductionTypeProductionPhaseID) as NodeID, dsys.Description as Node,dsys.Precedence, 3 as RootLevel
FROM ProductionTypeProductionPhase pppt
JOIN (Select Max(EffectiveDate) as EffectiveDate, ProductionTypeProductionPhaseID
	FROM ProductionTypeProductionPhase
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY ProductionTypeProductionPhaseID) dpha--derived table of distinct assigned Production Phases
ON dpha.ProductionTypeProductionPhaseID=pppt.ProductionTypeProductionPhaseID
AND dpha.EffectiveDate=pppt.EffectiveDate
JOIN  
( SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
FROM BioSecurityComponent bc
JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
	FROM BioSecurityComponent 
	WHERE EffectiveDate<=@EffectiveDate
	AND ComponentType=@CompType2
	GROUP BY ID) dbc--derived table of PhaseIDs for EffectiveDate
ON bc.EffectiveDate=dbc.EffectiveDate
AND bc.ID=dbc.ID
WHERE bc.ComponentType=@CompType2)dsys--derived table for phase descriptions and precedence
ON pppt.PigProductionPhaseID=dsys.ID
JOIN (Select Max(EffectiveDate) as EffectiveDate,SystemProductionTypeID,BioSecuritySystemID
	FROM SystemProductionType
	WHERE EffectiveDate<=@EffectiveDate
	GROUP by SystemProductionTypeID,BioSecuritySystemID) spt --derived table for system descriptions and precedence
ON pppt.SystemProductionTypeID=spt.SystemProductionTypeID

Where pppt.SystemProductionTypeID is not null

UNION
Select Distinct convert(varchar(5),pppt.SystemProductionTypeID) + '<pha>' + convert(varchar(5),ppbl.ProductionTypeProductionPhaseID) as ParentID, 
	convert(varchar(5),ppbl.ProductionTypeProductionPhaseID) + '<lev>' + convert(varchar(5),ppbl.ProductionPhaseBioSecurityLevelID) as NodeID, 'Level ' + convert(varchar(5),ppbl.Precedence) as Node,ppbl.Precedence, 4 as RootLevel
FROM ProductionPhaseBioSecurityLevel ppbl
JOIN (Select Max(EffectiveDate) as EffectiveDate,ProductionPhaseBioSecurityLevelID
	FROM ProductionPhaseBioSecurityLevel
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY ProductionPhaseBioSecurityLevelID) dlev--derived table of distinct assigned Levels
ON dlev.ProductionPhaseBioSecurityLevelID=ppbl.ProductionPhaseBioSecurityLevelID
AND dlev.EffectiveDate=ppbl.EffectiveDate
JOIN (Select Max(EffectiveDate) as EffectiveDate, SystemProductionTypeID, ProductionTypeProductionPhaseID
	FROM ProductionTypeProductionPhase
	Where EffectiveDate<=@EffectiveDate
	Group BY SystemProductionTypeID,ProductionTypeProductionPhaseID) pppt --derived table of LevelIDs for EffectiveDate
ON pppt.ProductionTypeProductionPhaseID=ppbl.ProductionTypeProductionPhaseID
where ppbl.ProductionTypeProductionPhaseID is not null
