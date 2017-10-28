CREATE PROCEDURE
    dbo.cfp_REPORT_MarketManagerPerformance_Targets
        @pMarketManagerID   char(06) 
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_REPORT_MarketManagerPerformance_Targets
     Author:    Chris Carson
    Created:    2016-10-04
    Purpose:    Returns Performance Targets for a given MarketingManagerID 


    Revision History:
    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2017-04-24          created


************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

SELECT 
    Weight_Tops             =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0
                                    ELSE 265
                                END

  , Weight_2d3d             =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0
                                    ELSE 290
                                END

  , Weight_CloseIBP         =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0
                                    ELSE 290
                                END

  , Weight_CloseSwift       =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0
                                    ELSE 260
                                END

  , Weight_CloseTriumph     =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0
                                    ELSE 290
                                END

  , STD_Tops                =   CASE @pMarketManagerID
                                    WHEN '000297' THEN 17.4
                                    WHEN '001826' THEN 17.6
                                    WHEN '002920' THEN 17.9
                                    WHEN '005194' THEN 16.5
                                    WHEN '005209' THEN 17.9
                                    WHEN '005522' THEN 18.0
                                    WHEN '005834' THEN 16.7
                                    WHEN '008476' THEN 18.1
                                    WHEN '009300' THEN 16.9
                                    ELSE 17.0
                                END

  , STD_2d3d_Tops           =   CASE @pMarketManagerID
                                    WHEN '000297' THEN 17.7
                                    WHEN '001826' THEN 16.7
                                    WHEN '002920' THEN 18.0
                                    WHEN '005194' THEN 14.7
                                    WHEN '005209' THEN 16.6
                                    WHEN '005522' THEN 18.2
                                    WHEN '005834' THEN 16.4
                                    WHEN '008476' THEN 17.8
                                    WHEN '009300' THEN 16.5
                                    ELSE 19.0 
                                END

  , STD_CloseIBP            =   CASE @pMarketManagerID
                                    WHEN '000000' THEN 0.0
                                    ELSE 22.0
                                END

  , STD_CloseSwift          =   CASE @pMarketManagerID
                                    WHEN '000297' THEN 20.8
                                    WHEN '001826' THEN 20.3
                                    WHEN '002920' THEN 19.9
                                    WHEN '005194' THEN 18.6
                                    WHEN '005209' THEN 19.9
                                    WHEN '005522' THEN 21.3
                                    WHEN '005834' THEN 18.9
                                    WHEN '008476' THEN 20.4
                                    WHEN '009300' THEN 19.1
                                    ELSE 20.0
                                END

  , STD_CloseTriumph        =   CASE @pMarketManagerID
                                    WHEN '000297' THEN 19.6
                                    WHEN '001826' THEN 18.9
                                    WHEN '002920' THEN 20.0
                                    WHEN '005194' THEN 17.3
                                    WHEN '005209' THEN 19.2
                                    WHEN '005522' THEN 20.0
                                    WHEN '005834' THEN 18.9
                                    WHEN '008476' THEN 19.6
                                    WHEN '009300' THEN 18.65
                                    ELSE 22.0
                                END
;

RETURN
