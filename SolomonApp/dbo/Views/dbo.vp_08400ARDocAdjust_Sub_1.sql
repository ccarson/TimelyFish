 

CREATE VIEW vp_08400ARDocAdjust_Sub_1 AS
   
   SELECT CustId, AdjdDocType, AdjdRefNbr, PerAppl= Max(PerAppl) 
   FROM ARAdjust 
   WHERE S4Future11 = ' ' AND
         AdjgDocType NOT IN('NS','RP') 
   GROUP BY CustId, AdjdDocType, AdjdRefNbr


 
