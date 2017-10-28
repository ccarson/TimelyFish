 

CREATE VIEW VR_03830 AS
					Select 
VendId = VendId,
VendName = VendName,
CpnyID = CpnyID,
January = SUM(January),
February = SUM(February),
March = SUM(March),
April = SUM(April),
May = SUM(May),
June = SUM(June),
July = SUM(July),
August = SUM(August),
September = SUM(September),
October = SUM(October),
November = SUM(November),
December = SUM(December)
From VR_03830_Det
Group By CpnyID, VendID, VendName


