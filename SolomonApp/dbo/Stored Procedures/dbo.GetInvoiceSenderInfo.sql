CREATE PROCEDURE GetInvoiceSenderInfo @SLUser VARCHAR(50) 
AS  
  SELECT Employee  
    FROM PJEMPLOY  
   WHERE PJEMPLOY.user_id = @SLUser  

