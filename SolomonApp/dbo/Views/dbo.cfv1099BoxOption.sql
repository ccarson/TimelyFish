CREATE VIEW cfv1099BoxOption (BoxDescr, BoxNbr, BoxOrder, tstamp)
	As
	--------------------------------------------------------------------------------------------------------
	-- PURPOSE:		This view is utilized to provide a list of options for the 1099 box field in the
	--				custom screen for importing AP vouchers. A PV is used, as using a text box was better
	--				for allowing pasting from Excel than the combo-box with a dropdown list
	-- CREATED BY:	Boyer & Associates, Inc. (TJones)
	-- CREATED ON:	2/13/2013
	--------------------------------------------------------------------------------------------------------
	SELECT CONVERT(CHAR(50), '<None>'), CONVERT(CHAR(2), ''), CONVERT(smallint, 0), CONVERT(timestamp, 0) 
	UNION SELECT CONVERT(CHAR(50), 'Rents'),CONVERT(CHAR(2),'1'),CONVERT(smallint, 1), CONVERT(timestamp, 1) 
	UNION SELECT CONVERT(CHAR(50), 'Royalties'),CONVERT(CHAR(2),'2'), CONVERT(smallint,2), CONVERT(timestamp, 2)
	UNION SELECT CONVERT(CHAR(50), 'Other Income'),CONVERT(CHAR(2),'3'),CONVERT(smallint,3), CONVERT(timestamp, 3)
	UNION SELECT CONVERT(CHAR(50), 'Federal Income Tax Withheld'),CONVERT(CHAR(2),'4'),CONVERT(smallint,4), CONVERT(timestamp, 4)
	UNION SELECT CONVERT(CHAR(50), 'Fishing Boat Proceeds'),CONVERT(CHAR(2),'5'),CONVERT(smallint,5), CONVERT(timestamp, 5)
	UNION SELECT CONVERT(CHAR(50), 'Medical and Health Care Payments'),CONVERT(CHAR(2),'6'),CONVERT(smallint,6), CONVERT(timestamp, 6)
	UNION SELECT CONVERT(CHAR(50), 'Nonemployee Compensation'),CONVERT(CHAR(2),'7'),CONVERT(smallint,7), CONVERT(timestamp, 7)
	UNION SELECT CONVERT(CHAR(50), 'Payments in Lieu of Dividends/Interest'),CONVERT(CHAR(2),'8'),CONVERT(smallint,8), CONVERT(timestamp, 8)
	UNION SELECT CONVERT(CHAR(50), 'Crop Insurance Proceeds'),CONVERT(CHAR(2),'10'),CONVERT(smallint,9), CONVERT(timestamp, 9)
	UNION SELECT CONVERT(CHAR(50), 'Excess Golden Parachute Payments'),CONVERT(CHAR(2),'13'),CONVERT(smallint,10), CONVERT(timestamp, 10)
	UNION SELECT CONVERT(CHAR(50), 'Gross Proceeds Paid to an Attorney'),CONVERT(CHAR(2),'14'),CONVERT(smallint,11), CONVERT(timestamp, 11)
	UNION SELECT CONVERT(CHAR(50), 'Section 409A Deferrals'),CONVERT(CHAR(2),'15'),CONVERT(smallint,12), CONVERT(timestamp, 12)
	UNION SELECT CONVERT(CHAR(50), 'Section 409A Income'),CONVERT(CHAR(2),'25'),CONVERT(smallint,13), CONVERT(timestamp, 13)
