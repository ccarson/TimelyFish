Create View VR_AR_Max_Payment
  AS
Select CustId,AdjdDoctype,AdjdRefNbr,Recordid=Max(RecordID)
  From aradjust Where AdjgDocType <> 'CM'
Group by CustId,AdjdDoctype,AdjdRefNbr
