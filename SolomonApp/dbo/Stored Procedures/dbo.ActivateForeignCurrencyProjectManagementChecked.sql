
create proc ActivateForeignCurrencyProjectManagementChecked
AS

SELECT control_data 
   FROM PJCONTRL 
  WHERE control_type = 'PA' 
    AND control_code = 'FOREIGN-CURRENCY-PROJECTS'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ActivateForeignCurrencyProjectManagementChecked] TO [MSDSL]
    AS [dbo];

