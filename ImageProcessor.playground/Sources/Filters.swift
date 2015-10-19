public class AbstractFilter {
    public init() {
        
    }
    
    public func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return rgbaImage
    }
}


public class FilterColorReduction : AbstractFilter {
    var palette: [Pixel]
    
    public init(palette: [Pixel]) {
        self.palette = palette
    }
    
    public override func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return colorReductionSimple(rgbaImage, palette: self.palette)
    }
}

public class FilterColorReductionDefault : FilterColorReduction {
    public init() {
        let black	= Pixel(redChanel: 0, greenChanel: 0, blueChanel: 0, alphaChanel: 255)
        let red		= Pixel(redChanel: 255, greenChanel: 0, blueChanel: 0, alphaChanel: 255)
        let green	= Pixel(redChanel: 0, greenChanel: 255, blueChanel: 0, alphaChanel: 255)
        let yellow	= Pixel(redChanel: 255, greenChanel: 255, blueChanel: 0, alphaChanel: 255)
        let blue	= Pixel(redChanel: 0, greenChanel: 0, blueChanel: 255, alphaChanel: 255)
        let magenta	= Pixel(redChanel: 255, greenChanel: 0, blueChanel: 255, alphaChanel: 255)
        let cyan	= Pixel(redChanel: 0, greenChanel: 255, blueChanel: 255, alphaChanel: 255)
        let white	= Pixel(redChanel: 255, greenChanel: 255, blueChanel: 255, alphaChanel: 255)
        let defaultPalette = [black, red, green, yellow, blue, magenta, cyan, white]
        
        super.init(palette: defaultPalette)
    }
}

public class FilterGreyscale : AbstractFilter {
    
    public override func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return greyscaleConversion(rgbaImage)
    }
}

public class FilterAdjustBrightness : AbstractFilter {
    var brightness: Int
    
    public init(brightness: Int) {
        self.brightness = brightness
    }
    
    public override func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return adjustBrightness(rgbaImage, brightness: brightness)
    }
}

public class FilterAdjustBrightness50 : FilterAdjustBrightness {
    public init() {
        super.init(brightness: 50)
    }
}

public class FilterAdjustBrightness128 : FilterAdjustBrightness {
    public init() {
        super.init(brightness: 128)
    }
}

public class FilterAdjustContrast : AbstractFilter {
    var contrast: Int
    
    public init(contrast: Int) {
        self.contrast = contrast
    }
    
    public override func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return adjustContrast(rgbaImage, contrast: contrast)
    }
}

public class FilterAdjustContrast128 : FilterAdjustContrast {
    public init() {
        super.init(contrast: 128)
    }
}

public class FilterColorInversion : AbstractFilter {

    public override func convert(rgbaImage: RGBAImage) -> RGBAImage {
        return colourInversion(rgbaImage)
    }
}
