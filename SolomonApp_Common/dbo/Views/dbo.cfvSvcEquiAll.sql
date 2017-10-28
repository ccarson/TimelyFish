
--*************************************************************
--	Purpose: Spreadsheet Report for Vehicle Assignement
--	Author: Sue Matter
--	Date: 10/1/2005
--	Usage: Spreadsheet for Glen and Karen
--	Parms: 
--	Updated:
--  BMD 9/26/2014 - added in "eq.user2" to capture sold cost for Clark Trebesh
--  BMD 10/2/2014 - added in the replace code to remove text from the field
--  BMD 12/1/2014 - added in the TareWeight and WtCapacity Columns to the view
--	DGD 6/7/2016  - added in the DOTStart and DOTExpire Columns
--*************************************************************

CREATE VIEW 
	dbo.cfvSvcEquiAll
AS
SELECT 
	eq.EquipID
  , eq.descr
  , eq.Status
  , eq.BranchId
  , eq.ManufId
  , eq.EquipTypeID
  , eq.MfgYear
  , eq.ModelId
  , eq.Type
  , eq.CpnyId
  , eq.LocationId
  , eq.StatusDate
  , SoldDate 	  	  =	eq.User8 
  , eq.User6
  , eq.VIN
  , eq.LicenseNbr
  , eq.RegistrSt
  , eq.RegistrDate
  , eq.Gvw
  , eq.Enhancement
  , ct.ContactName
  , OldID 			  =	eq.User5
  , rd1.ReadDate
  , rd1.Reading
  , eq.VendorId
  , eq.PurchDate
  , eq.PurchPoNbr
  , eq.PurchAmount
  , eq.PurActCost
  , PaymentAmount 	  = eq.user3 
  , LeaseTerm		  = eq.user4 
  , Commencementdate  = eq.user7 
  , pj.gl_subacct
  , SubDesc  		  = sb.Descr 
  , SoldAmount		  = CAST( REPLACE( REPLACE( eq.User2, '$', '' ), ',' , '') AS FLOAT)
  , eq.TareWeight
  , eq.WtCapacity 
  , VehicleType 	  = pj.pm_id05 
  , DOTStart 		  = eq.ExtWarrStartDate 
  , DOTExpire 		  = eq.ExtWarrEndDate
FROM 
	dbo.smSvcEquipment AS eq
LEFT JOIN 
	dbo.cftContact AS ct 		ON eq.User6 = ct.ContactID 
LEFT JOIN 	
	dbo.pjproj AS pj 			ON eq.User5 = pj.project
LEFT JOIN 	
	dbo.subacct AS sb 			ON pj.gl_SubAcct = sb.Sub
LEFT JOIN 
	dbo.smSvcReadings AS rd1 	ON eq.equipID = rd1.equipID 
									AND rd1.ReadDate =(	SELECT MAX( rd2.ReadDate ) FROM dbo.smSvcReadings AS rd2 
														WHERE rd2.equipID = eq.EquipID ) ;

