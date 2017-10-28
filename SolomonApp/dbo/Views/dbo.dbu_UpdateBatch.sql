-- Create View to find Adjg Payments, and Prepayments BankAcct,BankSub, and OrigDocamt from ARDoc
CREATE VIEW dbu_UpdateBatch AS

SELECT DISTINCT ADJBATNBR,CUSTID,ADJGREFNBR,ADJGDOCTYPE
  FROM ARADjust
 WHERE AdjgDoctype IN ('PA','PP')

