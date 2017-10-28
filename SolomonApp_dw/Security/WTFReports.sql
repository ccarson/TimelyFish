CREATE ROLE [WTFReports]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [WTFReports] ADD MEMBER [SE\Earth~WTF~DataReader];

