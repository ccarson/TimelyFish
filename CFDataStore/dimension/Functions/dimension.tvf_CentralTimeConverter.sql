
CREATE FUNCTION 
    dimension.tvf_CentralTimeConverter( 
        @pTimeValueToConvert    datetime 
      , @pConversionFunction    nvarchar(10) )

RETURNS TABLE 
AS

RETURN 

WITH 
    DSTDates AS( 
        SELECT DSTYear  =   1970, DSTStart    =   CONVERT( datetime, '1970-04-26 02:00:00' ), DSTEnd =   CONVERT( datetime, '1970-10-25 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1971, DSTStart    =   CONVERT( datetime, '1971-04-25 02:00:00' ), DSTEnd =   CONVERT( datetime, '1971-10-31 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1972, DSTStart    =   CONVERT( datetime, '1972-04-30 02:00:00' ), DSTEnd =   CONVERT( datetime, '1972-10-29 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1973, DSTStart    =   CONVERT( datetime, '1973-04-29 02:00:00' ), DSTEnd =   CONVERT( datetime, '1973-10-28 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1974, DSTStart    =   CONVERT( datetime, '1974-01-06 02:00:00' ), DSTEnd =   CONVERT( datetime, '1974-10-27 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1975, DSTStart    =   CONVERT( datetime, '1975-02-23 02:00:00' ), DSTEnd =   CONVERT( datetime, '1975-10-26 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1976, DSTStart    =   CONVERT( datetime, '1976-04-25 02:00:00' ), DSTEnd =   CONVERT( datetime, '1976-10-31 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1977, DSTStart    =   CONVERT( datetime, '1977-04-24 02:00:00' ), DSTEnd =   CONVERT( datetime, '1977-10-30 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1978, DSTStart    =   CONVERT( datetime, '1978-04-30 02:00:00' ), DSTEnd =   CONVERT( datetime, '1978-10-29 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1979, DSTStart    =   CONVERT( datetime, '1979-04-29 02:00:00' ), DSTEnd =   CONVERT( datetime, '1979-10-28 02:00:00' ) UNION ALL 

        SELECT DSTYear  =   1980, DSTStart    =   CONVERT( datetime, '1980-04-27 02:00:00' ), DSTEnd =   CONVERT( datetime, '1980-10-26 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1981, DSTStart    =   CONVERT( datetime, '1981-04-26 02:00:00' ), DSTEnd =   CONVERT( datetime, '1981-10-25 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1982, DSTStart    =   CONVERT( datetime, '1982-04-25 02:00:00' ), DSTEnd =   CONVERT( datetime, '1982-10-31 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1983, DSTStart    =   CONVERT( datetime, '1983-04-24 02:00:00' ), DSTEnd =   CONVERT( datetime, '1983-10-30 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1984, DSTStart    =   CONVERT( datetime, '1984-04-29 02:00:00' ), DSTEnd =   CONVERT( datetime, '1984-10-28 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1985, DSTStart    =   CONVERT( datetime, '1985-04-28 02:00:00' ), DSTEnd =   CONVERT( datetime, '1985-10-27 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1986, DSTStart    =   CONVERT( datetime, '1986-04-27 02:00:00' ), DSTEnd =   CONVERT( datetime, '1986-10-26 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1987, DSTStart    =   CONVERT( datetime, '1987-04-05 02:00:00' ), DSTEnd =   CONVERT( datetime, '1987-10-25 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1988, DSTStart    =   CONVERT( datetime, '1988-04-03 02:00:00' ), DSTEnd =   CONVERT( datetime, '1988-10-30 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1989, DSTStart    =   CONVERT( datetime, '1989-04-02 02:00:00' ), DSTEnd =   CONVERT( datetime, '1989-10-29 02:00:00' ) UNION ALL 

        SELECT DSTYear  =   1990, DSTStart    =   CONVERT( datetime, '1990-04-01 02:00:00' ), DSTEnd =   CONVERT( datetime, '1990-10-28 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1991, DSTStart    =   CONVERT( datetime, '1991-04-07 02:00:00' ), DSTEnd =   CONVERT( datetime, '1991-10-27 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1992, DSTStart    =   CONVERT( datetime, '1992-04-05 02:00:00' ), DSTEnd =   CONVERT( datetime, '1992-10-25 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1993, DSTStart    =   CONVERT( datetime, '1993-04-04 02:00:00' ), DSTEnd =   CONVERT( datetime, '1993-10-31 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1994, DSTStart    =   CONVERT( datetime, '1994-04-03 02:00:00' ), DSTEnd =   CONVERT( datetime, '1994-10-30 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1995, DSTStart    =   CONVERT( datetime, '1995-04-02 02:00:00' ), DSTEnd =   CONVERT( datetime, '1995-10-29 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1996, DSTStart    =   CONVERT( datetime, '1996-04-07 02:00:00' ), DSTEnd =   CONVERT( datetime, '1996-10-27 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1997, DSTStart    =   CONVERT( datetime, '1997-04-06 02:00:00' ), DSTEnd =   CONVERT( datetime, '1997-10-26 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1998, DSTStart    =   CONVERT( datetime, '1998-04-05 02:00:00' ), DSTEnd =   CONVERT( datetime, '1998-10-25 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   1999, DSTStart    =   CONVERT( datetime, '1999-04-04 02:00:00' ), DSTEnd =   CONVERT( datetime, '1999-10-31 02:00:00' ) UNION ALL 

        SELECT DSTYear  =   2000, DSTStart    =   CONVERT( datetime, '2000-04-02 02:00:00' ), DSTEnd =   CONVERT( datetime, '2000-10-29 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2001, DSTStart    =   CONVERT( datetime, '2001-04-01 02:00:00' ), DSTEnd =   CONVERT( datetime, '2001-10-28 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2002, DSTStart    =   CONVERT( datetime, '2002-04-07 02:00:00' ), DSTEnd =   CONVERT( datetime, '2002-10-27 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2003, DSTStart    =   CONVERT( datetime, '2003-04-06 02:00:00' ), DSTEnd =   CONVERT( datetime, '2003-10-26 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2004, DSTStart    =   CONVERT( datetime, '2004-04-04 02:00:00' ), DSTEnd =   CONVERT( datetime, '2004-10-31 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2005, DSTStart    =   CONVERT( datetime, '2005-04-03 02:00:00' ), DSTEnd =   CONVERT( datetime, '2005-10-30 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2006, DSTStart    =   CONVERT( datetime, '2006-04-02 02:00:00' ), DSTEnd =   CONVERT( datetime, '2006-10-29 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2007, DSTStart    =   CONVERT( datetime, '2007-03-11 02:00:00' ), DSTEnd =   CONVERT( datetime, '2007-11-04 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2008, DSTStart    =   CONVERT( datetime, '2008-03-09 02:00:00' ), DSTEnd =   CONVERT( datetime, '2008-11-02 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2009, DSTStart    =   CONVERT( datetime, '2009-03-08 02:00:00' ), DSTEnd =   CONVERT( datetime, '2009-11-01 02:00:00' ) UNION ALL 

        SELECT DSTYear  =   2010, DSTStart    =   CONVERT( datetime, '2010-03-14 02:00:00' ), DSTEnd =   CONVERT( datetime, '2010-11-07 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2011, DSTStart    =   CONVERT( datetime, '2011-03-13 02:00:00' ), DSTEnd =   CONVERT( datetime, '2011-11-06 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2012, DSTStart    =   CONVERT( datetime, '2012-03-11 02:00:00' ), DSTEnd =   CONVERT( datetime, '2012-11-04 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2013, DSTStart    =   CONVERT( datetime, '2013-03-10 02:00:00' ), DSTEnd =   CONVERT( datetime, '2013-11-03 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2014, DSTStart    =   CONVERT( datetime, '2014-03-09 02:00:00' ), DSTEnd =   CONVERT( datetime, '2014-11-02 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2015, DSTStart    =   CONVERT( datetime, '2015-03-08 02:00:00' ), DSTEnd =   CONVERT( datetime, '2015-11-01 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2016, DSTStart    =   CONVERT( datetime, '2016-03-13 02:00:00' ), DSTEnd =   CONVERT( datetime, '2016-11-06 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2017, DSTStart    =   CONVERT( datetime, '2017-03-12 02:00:00' ), DSTEnd =   CONVERT( datetime, '2017-11-05 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2018, DSTStart    =   CONVERT( datetime, '2018-03-11 02:00:00' ), DSTEnd =   CONVERT( datetime, '2018-11-04 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2019, DSTStart    =   CONVERT( datetime, '2019-03-10 02:00:00' ), DSTEnd =   CONVERT( datetime, '2019-11-03 02:00:00' ) UNION ALL 

        SELECT DSTYear  =   2020, DSTStart    =   CONVERT( datetime, '2020-03-08 02:00:00' ), DSTEnd =   CONVERT( datetime, '2020-11-01 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2021, DSTStart    =   CONVERT( datetime, '2021-03-14 02:00:00' ), DSTEnd =   CONVERT( datetime, '2021-11-07 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2022, DSTStart    =   CONVERT( datetime, '2022-03-13 02:00:00' ), DSTEnd =   CONVERT( datetime, '2022-11-06 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2023, DSTStart    =   CONVERT( datetime, '2023-03-12 02:00:00' ), DSTEnd =   CONVERT( datetime, '2023-11-05 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2024, DSTStart    =   CONVERT( datetime, '2024-03-10 02:00:00' ), DSTEnd =   CONVERT( datetime, '2024-11-03 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2025, DSTStart    =   CONVERT( datetime, '2025-03-09 02:00:00' ), DSTEnd =   CONVERT( datetime, '2025-11-02 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2026, DSTStart    =   CONVERT( datetime, '2026-03-08 02:00:00' ), DSTEnd =   CONVERT( datetime, '2026-11-01 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2027, DSTStart    =   CONVERT( datetime, '2027-03-14 02:00:00' ), DSTEnd =   CONVERT( datetime, '2027-11-07 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2028, DSTStart    =   CONVERT( datetime, '2028-03-12 02:00:00' ), DSTEnd =   CONVERT( datetime, '2028-11-05 02:00:00' ) UNION ALL 
        SELECT DSTYear  =   2029, DSTStart    =   CONVERT( datetime, '2029-03-11 02:00:00' ), DSTEnd =   CONVERT( datetime, '2029-11-04 02:00:00' ) )

SELECT 
    ConvertedDatetime   =   
        CASE 
            WHEN CONVERT( varchar(12), @pTimeValueToConvert, 114 ) = '00:00:00:000' THEN @pTimeValueToConvert
            ELSE 
                CASE @pConversionFunction 
                    WHEN N'To UTC' THEN 
                        CASE 
                            WHEN @pTimeValueToConvert BETWEEN DSTStart AND DSTEnd THEN DATEADD( hour, +5, @pTimeValueToConvert ) 
                            ELSE DATEADD( hour, +6, @pTimeValueToConvert )
                        END 
                    WHEN N'From UTC' THEN 
                        CASE 
                            WHEN @pTimeValueToConvert BETWEEN DSTStart AND DSTEnd THEN DATEADD( hour, -5, @pTimeValueToConvert ) 
                            ELSE DATEADD( hour, -6, @pTimeValueToConvert )        
                        END 
                END 
        END 
FROM
    DSTDates
WHERE 
    DATEPART( year, @pTimeValueToConvert ) = DSTYear  ;