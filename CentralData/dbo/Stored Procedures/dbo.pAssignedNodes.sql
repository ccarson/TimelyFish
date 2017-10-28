--Created by: Charity Gaborik
--Created Date: 4/14/2003
--Creates a recordset of all child nodes assigned to a specific parent
--Used in BioSecurity app as the recordsource for the assigned list
--Effective date is passed in to filter the records for a specific date
--ParentID and component type are passed in to filter for a specific parent component
Create Procedure dbo.pAssignedNodes
	@Parent varchar(20),
	@CompType varchar(3),
	@EffectiveDate smalldatetime

as
if @CompType='bio'
begin
	Select * from 
	(Select Distinct bss.BioSecurityID as ParentID,dsys.ID as NodeID, dsys.Description as Node,dsys.Precedence
	FROM 
		(Select Max(EffectiveDate) as EffectiveDate, BioSecuritySystemID
		FROM BioSecuritySystem
		WHERE EffectiveDate<=@EffectiveDate
		Group by BioSecuritySystemID) dbio
	JOIN BioSecuritySystem bss
	ON bss.BioSecuritySystemID=dbio.BioSecuritySystemID
	AND bss.EffectiveDate=dbio.EffectiveDate
	JOIN  
	( SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType='sys'
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType='sys') dsys
	ON bss.PigSystemID=dsys.ID) derived
	WHERE derived.ParentID=@Parent
	ORDER BY Precedence
END
if @CompType='sys'
begin
	Select * from 
	(Select spt.BioSecuritySystemID as ParentID, dsys.ID as NodeID, dsys.Description as Node,dsys.Precedence
	FROM
	(Select Max(EffectiveDate) as EffectiveDate, SystemProductionTypeID
		FROM SystemProductionType
		WHERE EffectiveDate<=@EffectiveDate
		Group by SystemProductionTypeID) dtyp
	JOIN SystemProductionType spt
	ON spt.SystemProductionTypeID=dtyp.SystemProductionTypeID
	AND spt.EffectiveDate=dtyp.EffectiveDate
	JOIN  
	( SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType='typ'
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType='typ')dsys
	ON spt.PigProductionTypeID=dsys.ID) derived
	WHERE derived.ParentID=@Parent
	ORDER BY Precedence
END
if @CompType='typ'
Begin
	
	Select * from
	(Select pppt.SystemProductionTypeID as ParentID, dsys.ID as NodeID,
		dsys.Description as Node, dsys.Precedence 
	FROM
	(Select Max(EffectiveDate) as EffectiveDate, ProductionTypeProductionPhaseID
		FROM ProductionTypeProductionPhase
		WHERE EffectiveDate<=@EffectiveDate
		Group by ProductionTypeProductionPhaseID) dpha
	JOIN ProductionTypeProductionPhase pppt
	ON pppt.ProductionTypeProductionPhaseID=dpha.ProductionTypeProductionPhaseID
	AND pppt.EffectiveDate=dpha.EffectiveDate
	JOIN
	(SELECT bc.EffectiveDate,bc.ID as ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType='pha'
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType='pha')dsys
	ON dsys.ID=pppt.PigProductionPhaseID) derived
	Where derived.ParentID=@Parent
	ORDER BY Precedence
END
if @CompType='pha'
Begin
	Select * from
	(Select Distinct ppbl.ProductionTypeProductionPhaseID as ParentID, 
		ppbl.ProductionPhaseBioSecurityLevelID as NodeID, 'Level ' + convert(varchar(5),ppbl.Precedence) as Node,ppbl.Precedence
	FROM ProductionPhaseBioSecurityLevel ppbl
	JOIN (Select Max(EffectiveDate) as EffectiveDate,ProductionPhaseBioSecurityLevelID
		FROM ProductionPhaseBioSecurityLevel
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY ProductionPhaseBioSecurityLevelID) dlev
	ON dlev.ProductionPhaseBioSecurityLevelID=ppbl.ProductionPhaseBioSecurityLevelID
	and dlev.EffectiveDate=ppbl.EffectiveDate) derived
	Where derived.ParentID=@Parent
	ORDER BY Precedence	
	
END
Begin
if @CompType='lev'
	Select sbsl.ProductionPhaseBioSecurityLevelID as ParentID,c.ContactID as NodeID,c.ContactName as Node, 0 as Precedence from
	SiteBioSecurity sbsl
	JOIN	
	(Select Max(EffectiveDate) as EffectiveDate, ContactID
	FROM SiteBioSecurity
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY ContactID) dsit
	ON dsit.ContactID=sbsl.ContactID and dsit.EffectiveDate=sbsl.EffectiveDate
	JOIN Contact c
	ON c.ContactID=dsit.ContactID
	and sbsl.ProductionPhaseBioSecurityLevelID=@Parent
Order BY c.ContactName
End

