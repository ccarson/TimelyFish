 CREATE Proc EDSOShipHeader_DimensionUpdate @CpnyId varchar(10), @ShipperId varchar(15), @Weight float, @WeightUOM varchar(6), @Volume float, @VolumeUOM varchar(6), @Length float, @LengthUOM varchar(6), @Height float, @HeightUOM varchar(6), @Width float, @WidthUOM varchar(6), @AltBOLNbr varchar(20) As
Update EDSOShipHeader Set Weight = @Weight, WeightUOM = @WeightUOM, Volume = @Volume,
  VolumeUOM = @VolumeUOM, Len = @Length, LenUOM = @LengthUOM, Height = @Height,
  HeightUOM = @HeightUOM, Width = @Width, WidthUOM = @WidthUOM, S4Future01 = @AltBOLNbr
  Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_DimensionUpdate] TO [MSDSL]
    AS [dbo];

