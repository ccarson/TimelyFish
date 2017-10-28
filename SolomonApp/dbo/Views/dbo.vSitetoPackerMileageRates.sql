Create View [dbo].[vSitetoPackerMileageRates]

as 

select DescriptiveName,
  	HormelAustinRate=(max(Case ContactName when  'Hormel-Austin' 
			then Rate  end )),
	MorrellSiouxCityRate=(max(Case ContactName when  'Morrell-Sioux City'
			then Rate end )) , 
	MorrellSiouxFallsRate=(max(Case ContactName when  'Morrell-Sioux Falls' 
			then Rate end )),
	ParksWelcomeRate=(max(Case ContactName when  'Parks Welcome' 
			then Rate end )),
	SwiftMarshalltownRate=(max(Case ContactName when  'Swift-Marshalltown' 
			then Rate end )),
 	SwiftWorthingtonRate=(max(Case ContactName when  'Swift-Worthington' 
			then Rate end )),
	IBPStormLakeRate=(max(Case ContactName when  'IBP Storm Lake' 
			then Rate end )),
	IBPWaterlooRate=(max(Case ContactName when  'IBP Waterloo' 
			then Rate end )),
	FarmlandCreteRate=(max(Case ContactName when  'Farmland, Crete' 
			then Rate end )),
 	FarmlandDenisonRate=(max(Case ContactName when  'Farmland, Denison' 
			then Rate end )), 
 	IBPColumbusRate=(max(Case ContactName when  'IBP Columbus Jctn' 
			then Rate end )),
  	HormelAustinTime=(max(Case ContactName when  'Hormel-Austin' 
			then OneWayHours  end )),
	MorrellSiouxCityTime=(max(Case ContactName when  'Morrell-Sioux City'
			then OneWayHours end )) , 
	MorrellSiouxFallsTime=(max(Case ContactName when  'Morrell-Sioux Falls' 
			then OneWayHours end )),
	ParksWelcomeTime=(max(Case ContactName when  'Parks Welcome' 
			then OneWayHours end )),
	SwiftMarshalltownTime=(max(Case ContactName when  'Swift-Marshalltown' 
			then OneWayHours end )),
 	SwiftWorthingtonTime=(max(Case ContactName when  'Swift-Worthington' 
			then OneWayHours end )) ,
	HormelAustinMiles=(max(Case ContactName when  'Hormel-Austin' 
			then OneWayMiles  end )),
	MorrellSiouxCityMiles=(max(Case ContactName when  'Morrell-Sioux City'
			then OneWayMiles end )) , 
	MorrellSiouxFallsMiles=(max(Case ContactName when  'Morrell-Sioux Falls' 
			then OneWayMiles end )),
	ParksWelcomeMiles=(max(Case ContactName when  'Parks Welcome' 
			then OneWayMiles end )),
	SwiftMarshalltownMiles=(max(Case ContactName when  'Swift-Marshalltown' 
			then OneWayMiles end )),
 	SwiftWorthingtonMiles=(max(Case ContactName when  'Swift-Worthington' 
			then OneWayMiles end )),
	IBPStormLakeMiles=(max(Case ContactName when  'IBP Storm Lake' 
			then OneWayMiles end )),
	IBPWaterlooMiles=(max(Case ContactName when  'IBP Waterloo' 
			then OneWayMiles end )),
	FarmlandCreteMiles=(max(Case ContactName when  'Farmland, Crete' 
			then OneWayMiles end )),
 	FarmlandDenisonMiles=(max(Case ContactName when  'Farmland, Denison' 
			then OneWayMiles end )),
 	IBPColumbusMiles=(max(Case ContactName when  'IBP Columbus Jctn' 
			then OneWayMiles end )), 
 	ExcelMiles=(max(Case ContactName when  'Excel' 
			then OneWayMiles end )),
	ExcelTime=(max(Case ContactName when  'Excel' 
			then OneWayHours end )),
	ExcelRate=(max(Case ContactName when  'Excel' 
			then Rate end )),
	EllsworthMiles=(max(Case ContactName when  'Parks Ellsworth' 
			then OneWayMiles end )),
	EllsworthTime=(max(Case ContactName when  'Parks Ellsworth' 
			then OneWayHours end )),
	EllsworthRate=(max(Case ContactName when  'Parks Ellsworth' 
			then Rate end )),0 as testGroup
from CentralData.dbo.vSitetoPackerMileage
Group by DescriptiveName 


