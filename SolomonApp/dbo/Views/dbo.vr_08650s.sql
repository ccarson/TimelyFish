 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_08650s AS

SELECT v.ClassId, v.CustId, v.Fax, v.Name, v.Phone, v.Status, v.StmtCycleId, b.AvgDayToPay, 
       b.CurrBal, b.FutureBal, h.YtdSales, 
       b.CpnyID, cRI_ID= c.RI_ID, c.CpnyName,
       v.User1 as CustUser1, v.User2 as CustUser2, v.User3 as CustUser3, v.User4 as CustUser4,
       v.User5 as CustUser5, v.User6 as CustUser6, v.User7 as CustUser7, v.User8 as CustUser8
  FROM Customer v LEFT OUTER JOIN AR_Balances b 
                    ON v.CustId = b.CustID
                  JOIN RptCompany c 
                    ON ISNULL(b.CpnyID,c.Cpnyid) = c.CpnyID
                  LEFT OUTER JOIN ARHist h 
                    ON b.CpnyID = h.CpnyID AND b.CustID = h.CustId 
                   AND SUBSTRING(b.PerNbr,1,4) = h.Fiscyr
                  LEFT OUTER JOIN vs_Company s 
                    ON b.CpnyID = s.CpnyID

 
