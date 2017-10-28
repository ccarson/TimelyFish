
Create Procedure dbo.pBioSecurityReport
	@EffectiveDate smalldatetime
AS
Select @EffectiveDate as EffectiveDate,dcontact.ContactID, dcontact.ContactName, dLevel.LevelID,dlevel.LevelName, dlevel.LevelPrecedence, dphase.PhaseName, 
	dphase.PhasePrecedence, dtype.TypName, dtype.TypePrecedence, dsystem.SystemName, dsystem.SystemPrecedence
FROM 
	(Select sbs.ProductionPhaseBioSecurityLevelID as LevelID, sbs.ContactID, c.ContactName
	FROM
		(Select Max(EffectiveDate) as EffectiveDate, ContactID 
		FROM SiteBioSecurity
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY ContactID) maxcontact
		
		JOIN SiteBioSecurity sbs
		ON sbs.EffectiveDate=maxcontact.EffectiveDate
		AND sbs.ContactID=maxcontact.ContactID
		
		JOIN Contact c 	
		ON c.ContactID=sbs.ContactID) dcontact
JOIN
	(Select ppbl.ProductionTypeProductionPhaseID as PhaseID,ppbl.ProductionPhaseBioSecurityLevelID as LevelID,
		ppbl.Description as LevelName, ppbl.Precedence as LevelPrecedence
	FROM 
		(Select Max(EffectiveDate) as EffectiveDate, ProductionPhaseBioSecurityLevelID 
		FROM ProductionPhaseBioSecurityLevel
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY ProductionPhaseBioSecurityLevelID) maxlevel
		
		JOIN ProductionPhaseBioSecurityLevel ppbl
		ON ppbl.EffectiveDate=maxlevel.EffectiveDate
		AND ppbl.ProductionPhaseBioSecurityLevelID=maxlevel.ProductionPhaseBioSecurityLevelID) dlevel
ON dcontact.LevelID=dlevel.LevelID
JOIN
	(Select pppt.SystemProductionTypeID as TypeID, pppt.ProductionTypeProductionPhaseID as PhaseID,
		dcompphase.Description as PhaseName, dcompphase.Precedence as PhasePrecedence
	FROM
		(Select Max(EffectiveDate) as EffectiveDate,ProductionTypeProductionPhaseID
		FROM ProductionTypeProductionPhase
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY ProductionTypeProductionPhaseID) maxphase
		
		JOIN ProductionTypeProductionPhase pppt
		ON pppt.EffectiveDate=maxphase.EffectiveDate
		AND pppt.ProductionTypeProductionPhaseID=maxphase.ProductionTypeProductionPhaseID
		
		JOIN
			(Select bc.ID, bc.Description, bc.Precedence
			FROM 
				(Select Max(EffectiveDate) as EffectiveDate, ID
				FROM BioSecurityComponent
				WHERE EffectiveDate<=@EffectiveDate
				AND ComponentType='pha'
				GROUP BY ID) maxphacomp
			JOIN BioSecurityComponent bc
			ON bc.ID=maxphacomp.ID
			AND bc.EffectiveDate=maxphacomp.EffectiveDate
			AND bc.ComponentType='pha') dcompphase
		ON dcompphase.ID=pppt.PigProductionPhaseID) dPhase
ON dLevel.PhaseID=dPhase.PhaseID
JOIN
	(Select spt.BioSecuritySystemID as SystemID, spt.SystemProductionTypeID as TypeID,
		dcomptype.Description as TypName, dcomptype.Precedence as TypePrecedence
	FROM
		(Select Max(EffectiveDate) as EffectiveDate,SystemProductionTypeID
		FROM SystemProductionType spt
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY SystemProductionTypeID) maxtype
		
		JOIN SystemProductionType spt
		ON spt.EffectiveDate=maxtype.EffectiveDate
		AND spt.SystemProductionTypeID=maxtype.SystemProductionTypeID
		
		JOIN
			(Select bc.ID, bc.Description, bc.Precedence
			FROM 
				(Select Max(EffectiveDate) as EffectiveDate, ID
				FROM BioSecurityComponent
				WHERE EffectiveDate<=@EffectiveDate
				AND ComponentType='typ'
				GROUP BY ID) maxtypcom
			JOIN BioSecurityComponent bc
			ON bc.ID=maxtypcom.ID
			AND bc.EffectiveDate=maxtypcom.EffectiveDate
			AND bc.ComponentType='typ') dcomptype
		ON dcomptype.ID=spt.PigProductionTypeID) dType
ON dPhase.TypeID=dType.TypeID
JOIN
	(Select bss.BioSecurityID as BioSecurityID, bss.PigSystemID as SystemID,
		dcompsys.Description as SystemName, dcompsys.Precedence as SystemPrecedence
	FROM
		(Select Max(EffectiveDate) as EffectiveDate,BioSecuritySystemID
		FROM BioSecuritySystem
		WHERE EffectiveDate<=@EffectiveDate
		GROUP BY BioSecuritySystemID) maxsystem
		
		JOIN BioSecuritySystem bss
		ON bss.EffectiveDate=maxsystem.EffectiveDate
		AND bss.BioSecuritySystemID=maxsystem.BioSecuritySystemID
		
		JOIN
			(Select bc.ID, bc.Description, bc.Precedence
			FROM 
				(Select Max(EffectiveDate) as EffectiveDate, ID
				FROM BioSecurityComponent
				WHERE EffectiveDate<=@EffectiveDate
				AND ComponentType='sys'
				GROUP BY ID) maxsyscomp
			JOIN BioSecurityComponent bc
			ON bc.ID=maxsyscomp.ID
			AND bc.EffectiveDate=maxsyscomp.EffectiveDate
			AND bc.ComponentType='sys') dcompsys
		ON dcompsys.ID=bss.PigSystemID) dSystem
ON dSystem.SystemID=dType.SystemID
