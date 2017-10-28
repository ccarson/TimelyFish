-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 12/15/2011
-- Description:	Returns a bearing between two point coordinates
-- ==================================================================

/**
* @function   : Bearing
* @precis     : Returns a bearing between two point coordinates
* @version    : 1.0
* @usage      : FUNCTION Bearing(@p_dE1  float,
*                                @p_dN1 float,
*                                @p_dE2 float,
*                                @p_dN2 float )
*                RETURNS GEOMETRY
*               eg select cogo.Bearing(0,0,45,45) * (180/PI()) as Bearing;
* @param      : p_dE1     : X Ordinate of start point of bearing
* @paramtype  : p_dE1     : FLOAT
* @param      : p_dN1     : Y Ordinate of start point of bearing
* @paramtype  : p_dN1     : FLOAT
* @param      : p_dE2     : X Ordinate of end point of bearing
* @paramtype  : p_dE2     : FLOAT
* @param      : p_dN2     : Y Ordinate of end point of bearing
* @paramtype  : p_dN2     : FLOAT
* @return     : bearing   : Bearing between point 1 and 2 from 0-360 (in radians)
* @rtnType    : bearing   : Float
* @note       : Does not throw exceptions
* @note       : Assumes planar projection eg UTM.
* @history    : Simon Greener  - Feb 2005 - Original coding.
* @history    : Simon Greener  - May 2011 - Converted to SQL Server
  * @copyright  : Licensed under a Creative Commons Attribution-Share Alike 2.5 Australia License. (http://creativecommons.org/licenses/by-sa/2.5/au/)
*/
Create Function [dbo].[cff_Bearing](@p_dE1 Float, @p_dN1 Float,
                                 @p_dE2 Float, @p_dN2 Float)
Returns Float
AS
Begin
    Declare
        @dBearing Float,
        @dEast    Float,
        @dNorth   Float;
    BEGIN
        If (@p_dE1 IS NULL OR
            @p_dN1 IS NULL OR
            @p_dE2 IS NULL OR
            @p_dE1 IS NULL ) 
           Return NULL;
 
        If ( (@p_dE1 = @p_dE2) AND 
             (@p_dN1 = @p_dN2) ) 
           Return NULL;
 
        SET @dEast  = @p_dE2 - @p_dE1;
        SET @dNorth = @p_dN2 - @p_dN1;
        If ( @dEast = 0 ) 
        Begin
            If ( @dNorth < 0 ) 
                SET @dBearing = PI();
            Else
                SET @dBearing = 0;
        End
        Else
            SET @dBearing = -aTan(@dNorth / @dEast) + PI() / 2.0;
             
        If ( @dEast < 0 ) 
            SET @dBearing = @dBearing + PI();
 
        Return @dBearing;
    End
End;

