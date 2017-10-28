create Procedure [dbo].[pXF170cftPfosBinTrack_Header] @binNbr varchar (6), @PigGroupID char (10) as 
    Select * from cftPfosBinTrack Where BinNbr = @binNbr and PigGroupID like @PigGroupID 