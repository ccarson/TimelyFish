CREATE PROCEDURE GetInvoiceEmployeeInfo @Project VARCHAR(16) 
AS  
SELECT biller, manager1
  FROM PJBILL JOIN PJPROJ
                ON PJBILL.project = PJPROJ.project 
 WHERE PJProj.project = @Project     

