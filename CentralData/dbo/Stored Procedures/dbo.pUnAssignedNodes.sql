
Create Procedure dbo.pUnAssignedNodes
	@Parent varchar(20),
	@CompType varchar(3),
	@EffectiveDate smalldatetime
AS
Declare @CompTypeChild varchar(3)
if @CompType='bio' 
Begin
Select @CompTypeChild='sys'
	Select bc.EffectiveDate,bc.ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType=@CompTypeChild
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType=@CompTypeChild
	AND bc.ID not IN
	(Select NodeID from
		(Select bss.PigSystemID as NodeID, bss.BioSecurityID as ParentID FROM 
		(Select Max(EffectiveDate) as EffectiveDate,BioSecuritySystemID
		FROM BioSecuritySystem
		Where EffectiveDate<=@EffectiveDate
		GROUP BY BioSecuritySystemID)dsys
		JOIN BioSecuritySystem bss
		ON bss.BioSecuritySystemID=dsys.BioSecuritySystemID
		AND bss.EffectiveDate=dsys.EffectiveDate) derived
		Where derived.ParentID=@Parent)
END
IF @CompType='sys'
BEGIN
Select @CompTypeChild='typ'
	Select bc.EffectiveDate,bc.ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType=@CompTypeChild
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType=@CompTypeChild
	AND bc.ID not IN
		(Select NodeID from
		(Select spt.PigProductionTypeID as NodeID, spt.BioSecuritySystemID as ParentID FROM 
		(Select Max(EffectiveDate) as EffectiveDate,SystemProductionTypeID
		FROM SystemProductionType
		Where EffectiveDate<=@EffectiveDate
		GROUP BY SystemProductionTypeID)dtyp
		JOIN SystemProductionType spt
		ON spt.SystemProductionTypeID=dtyp.SystemProductionTypeID
		AND spt.EffectiveDate=dtyp.EffectiveDate) derived
		Where derived.ParentID=@Parent)
END
IF @CompType='typ'
Begin
Select @CompTypeChild='pha'
	Select bc.EffectiveDate,bc.ID,bc.Description, bc.Precedence
	FROM BioSecurityComponent bc
	JOIN (SELECT Max(EffectiveDate) as EffectiveDate, ID
		FROM BioSecurityComponent 
		WHERE EffectiveDate<=@EffectiveDate
		AND ComponentType=@CompTypeChild
		GROUP BY ID) dbc
	ON bc.EffectiveDate=dbc.EffectiveDate
	AND bc.ID=dbc.ID
	WHERE bc.ComponentType=@CompTypeChild
	AND bc.ID not IN
	(Select NodeID from
		(Select pppt.PigProductionPhaseID as NodeID, SystemProductionTypeID as ParentID FROM 
		(Select Max(EffectiveDate) as EffectiveDate,ProductionTypeProductionPhaseID
		FROM ProductionTypeProductionPhase
		Where EffectiveDate<=@EffectiveDate
		GROUP BY ProductionTypeProductionPhaseID)dpha
		JOIN ProductionTypeProductionPhase pppt
		ON pppt.ProductionTypeProductionPhaseID=dpha.ProductionTypeProductionPhaseID
		AND pppt.EffectiveDate=dpha.EffectiveDate) derived
		Where derived.ParentID=@Parent)
END
IF @CompType='pha'
BEGIN
Select 
	'' as EffectiveDate, 0 as ID, '' as Description, 0 as Precedence	
END
IF @CompType='lev'
BEGIN	
	Select '' as EffectiveDate, c.ContactID as ID,c.ContactName as Description, 0 as Precedence
	FROM Contact c
	JOIN Site s ON
	S.ContactID=c.ContactID
	WHERE c.StatusTypeID=1 and c.ContactID Not IN
	(Select sbs.ContactID FROM
	(Select Max(EffectiveDate) as EffectiveDate, ContactID
	FROM SiteBioSecurity
	WHERE EffectiveDate<=@EffectiveDate
	GROUP BY ContactID) derived
	JOIN SiteBioSecurity sbs ON Derived.ContactID=sbs.ContactID
		and derived.EffectiveDate=sbs.EffectiveDate
	Where sbs.ProductionPhaseBioSecurityLevelID is not null)
	ORDER BY c.ContactName
END
