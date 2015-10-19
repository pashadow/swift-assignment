import UIKit

public struct ImageProcessor {
    var rgbaImage: RGBAImage

    public init(image: UIImage) {
        rgbaImage = RGBAImage(image: image)!
    }

    public init(image: UIImage, filters: [AbstractFilter]) {
        self.init(image: image)
        for filter in filters {
            rgbaImage = filter.convert(rgbaImage)
        }
    }
    
     public func toUIImage() -> UIImage {
        return rgbaImage.toUIImage()!
    }
    
    public mutating func apply(name: String) {
        if name == "ColorReduction" {
            self.rgbaImage = FilterColorReductionDefault().convert(rgbaImage)
        } else if name == "Greyscale" {
            self.rgbaImage = FilterGreyscale().convert(rgbaImage)
        } else if name == "Brightness128" {
            self.rgbaImage = FilterAdjustBrightness128().convert(rgbaImage)
        }
    }
}