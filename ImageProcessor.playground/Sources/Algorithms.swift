import Darwin

// LESSON EXAMPLES
// 1. if sum of colors is less avg sum - make pixel black
public func contrastTransformation1(rgbaImage: RGBAImage) -> RGBAImage {
    // Preprocessing. Calculate average colors
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            totalRed += Int(pixel.red)
            totalGreen += Int(pixel.green)
            totalBlue += Int(pixel.blue)
        }
    }
    
    let pixelCount = rgbaImage.width * rgbaImage.height
    let avgRed = totalRed / pixelCount
    let avgGreen = totalGreen / pixelCount
    let avgBlue = totalBlue / pixelCount
    let sum = avgRed + avgGreen + avgBlue
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            if (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) < sum) {
                rgbaImage.updatePixel(x, y: y, redFunc: {red in 0}, greenFunc: {green in 0}, blueFunc: {blue in 0})
            }
        }
    }
    return rgbaImage
}

// 2. Increase contrast separately
public func contrastTransformation2(rgbaImage: RGBAImage) -> RGBAImage {
    // Preprocessing. Calculate average colors
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            totalRed += Int(pixel.red)
            totalGreen += Int(pixel.green)
            totalBlue += Int(pixel.blue)
        }
    }
    
    let pixelCount = rgbaImage.width * rgbaImage.height
    let avgRed = totalRed / pixelCount
    let avgGreen = totalGreen / pixelCount
    let avgBlue = totalBlue / pixelCount
    let sum = avgRed + avgGreen + avgBlue

    let n = 10
    let m = 1
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            let redDelta = Int(pixel.red) - avgRed
            let greenDelta = Int(pixel.green) - avgGreen
            let blueDelta = Int(pixel.blue) - avgBlue
            var modifier = n
            if (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) < sum) {
                modifier = m
            }
            rgbaImage.updatePixel(x, y: y, redFunc: {red in avgRed + modifier * redDelta}, greenFunc: {green in avgGreen + modifier * greenDelta}, blueFunc: {blue in avgBlue + modifier * blueDelta})
        }
    }
    return rgbaImage
}

// 3. Increase contrast separately by chanels
public func contrastTransformation3(rgbaImage: RGBAImage) -> RGBAImage {
    // Preprocessing. Calculate average colors
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            totalRed += Int(pixel.red)
            totalGreen += Int(pixel.green)
            totalBlue += Int(pixel.blue)
        }
    }
    
    let pixelCount = rgbaImage.width * rgbaImage.height
    let avgRed = totalRed / pixelCount
    let avgGreen = totalGreen / pixelCount
    let avgBlue = totalBlue / pixelCount

    let red_n = 5
    let green_n = 10
    let blue_n = 2
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            let redDelta = Int(pixel.red) - avgRed
            let greenDelta = Int(pixel.green) - avgGreen
            let blueDelta = Int(pixel.blue) - avgBlue
            
            var red_modifier = red_n
            if (Int(pixel.red) < avgRed) {
                red_modifier = 1
            }
            var green_modifier = green_n
            if (Int(pixel.green) < avgGreen) {
                green_modifier = 1
            }
            var blue_modifier = blue_n
            if (Int(pixel.blue) < avgBlue) {
                blue_modifier = 1
            }

            rgbaImage.updatePixel(x, y: y, redFunc: {red in avgRed + red_modifier * redDelta}, greenFunc: {green in avgGreen + green_modifier * greenDelta}, blueFunc: {blue in avgBlue + blue_modifier * blueDelta})
        }
    }
    return rgbaImage
}

// 4. Make it grayscale
public func simpleGreyscaleTransformation(rgbaImage: RGBAImage) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            let avgColor = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)) / 3

            rgbaImage.updatePixel(x, y: y, redFunc: {red in avgColor}, greenFunc: {green in avgColor}, blueFunc: {blue in avgColor})
        }
    }
    return rgbaImage
}

// 5. Swap chanels
public func swapChanels(rgbaImage: RGBAImage, chanels: String) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            if chanels == "RG" || chanels == "GR" {
                rgbaImage.updatePixel(x, y: y, redFunc: {red in Int(pixel.green)}, greenFunc: {green in Int(pixel.red)}, blueFunc: {blue in blue})
            } else if chanels == "GB" || chanels == "BG" {
                rgbaImage.updatePixel(x, y: y, redFunc: {red in red}, greenFunc: {green in Int(pixel.blue)}, blueFunc: {blue in Int(pixel.green)})
            } else if chanels ==  "RB" || chanels == "BR" {
                rgbaImage.updatePixel(x, y: y, redFunc: {red in Int(pixel.blue)}, greenFunc: {green in green}, blueFunc: {blue in Int(pixel.red)})
            }
        }
    }
    return rgbaImage
}

//IMAGE PROCESSING ALGORITHMS
//http://www.dfstudios.co.uk/articles/programming/image-programming-algorithms/

//1. FINDING THE NEAREST COLOUR
//http://www.dfstudios.co.uk/?page_id=484
public func colorReductionSimple(rgbaImage: RGBAImage, palette: [Pixel]) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            var pixel = rgbaImage.getPixel(x, y: y)!
            
            var nearestColour = pixel
            var minimumDistance = 255*255 + 255*255 + 255*255 + 1
            for paletteColour in palette {
                let redDiff = Int(pixel.red) - Int(paletteColour.red)
                let greenDiff = Int(pixel.green) - Int(paletteColour.green)
                let blueDiff = Int(pixel.blue) - Int(paletteColour.blue)
                let distance = redDiff*redDiff + greenDiff*greenDiff + blueDiff*blueDiff
                if (distance < minimumDistance) {
                    minimumDistance = distance
                    nearestColour = paletteColour
                }
            }
            pixel.red = nearestColour.red
            pixel.green = nearestColour.green
            pixel.blue = nearestColour.blue

            rgbaImage.setPixel(x, y: y, pixel: pixel)
        }
    }
    return rgbaImage
}

// 2. ERROR DIFFUSION
// http://www.dfstudios.co.uk/?page_id=460
public func colorReductionDiffusion(rgbaImage: RGBAImage, palette: [Pixel]) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            var pixel = rgbaImage.getPixel(x, y: y)!
            var nearestColour = pixel
            var minimumDistance = 255*255 + 255*255 + 255*255 + 1
            for paletteColour in palette {
                let redDiff = Int(pixel.red) - Int(paletteColour.red)
                let greenDiff = Int(pixel.green) - Int(paletteColour.green)
                let blueDiff = Int(pixel.blue) - Int(paletteColour.blue)
                let distance = redDiff*redDiff + greenDiff*greenDiff + blueDiff*blueDiff
                if (distance < minimumDistance) {
                    minimumDistance = distance
                    nearestColour = paletteColour
                }
            }
            
            // change current pixel
            pixel.red = nearestColour.red
            pixel.green = nearestColour.green
            pixel.blue = nearestColour.blue
            
            
            // save current pixel
            rgbaImage.setPixel(x, y: y, pixel: pixel)
            
            // calculate error
            let errorRed = Double(pixel.red - nearestColour.red)
            let errorGreen = Double(pixel.green - nearestColour.green)
            let errorBlue = Double(pixel.blue - nearestColour.blue)
            
            // diffuse error
            rgbaImage.updatePixel(x+1, y: y, redFunc: {red in red + Int(7.0/16.0 * errorRed)}, greenFunc: {green in green + Int(7.0/16.0 * errorGreen)}, blueFunc: {blue in blue + Int(7.0/16.0 * errorBlue)})
            rgbaImage.updatePixel(x-1, y: y+1, redFunc: {red in red + Int(3.0/16.0 * errorRed)}, greenFunc: {green in green + Int(3.0/16.0 * errorGreen)}, blueFunc: {blue in blue + Int(3.0/16.0 * errorBlue)})
            rgbaImage.updatePixel(x, y: y+1, redFunc: {red in red + Int(5.0/16.0 * errorRed)}, greenFunc: {green in green + Int(5.0/16.0 * errorGreen)}, blueFunc: {blue in blue + Int(5.0/16.0 * errorBlue)})
            rgbaImage.updatePixel(x+1, y: y+1, redFunc: {red in red + Int(1.0/16.0 * errorRed)}, greenFunc: {green in green + Int(1.0/16.0 * errorGreen)}, blueFunc: {blue in blue + Int(1.0/16.0 * errorBlue)})
        }
    }
    return rgbaImage
}

// 3. GREYSCALE CONVERSION
// http://www.dfstudios.co.uk/?page_id=445
public func greyscaleConversion(rgbaImage: RGBAImage) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            let pixel = rgbaImage.getPixel(x, y: y)!
            
            let avgRed = round(0.299 * Double(pixel.red))
            let avgGreen = round(0.587 * Double(pixel.green))
            let avgBlue = round(0.114 * Double(pixel.blue))
            let avgColor = Int(avgRed + avgGreen + avgBlue)
            
            rgbaImage.updatePixel(x, y: y, redFunc: {red in avgColor}, greenFunc: {green in avgColor}, blueFunc: {blue in avgColor})
        }
    }
    return rgbaImage
}

// 4. BRIGHTNESS ADJUSTMENT
// http://www.dfstudios.co.uk/?page_id=436
// The value of brightness will usually be in the range of -255 to +255 for a 24 bit palette
public func adjustBrightness(rgbaImage: RGBAImage, brightness: Int) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            rgbaImage.updatePixel(x, y: y, redFunc: {red in red + brightness}, greenFunc: {green in green + brightness}, blueFunc: {blue in blue + brightness})
        }
    }
    return rgbaImage
}

// 5. CONTRAST ADJUSTMENT
// http://www.dfstudios.co.uk/?page_id=423
// The value of contrast will be in the range of 0 to +255
public func adjustContrast(rgbaImage: RGBAImage, contrast: Int) -> RGBAImage {
    let factor = Double(259 * (contrast + 255)) / Double(255 * (259 - contrast))
    
    func adjustContrast(color: Int) -> Int {
        return Int(factor * Double(color - 128) + 128)
    }
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            rgbaImage.updatePixel(
                x,
                y: y,
                redFunc: adjustContrast,
                greenFunc: adjustContrast,
                blueFunc: adjustContrast
            )
        }
    }
    return rgbaImage
}


// 6. GAMMA CORRECTION
// http://www.dfstudios.co.uk/?page_id=408
// The range of values used for gamma will depend on the application, but personally I tend to use a range of 0.01 to 7.99
public func adjustGamma(rgbaImage: RGBAImage, gamma: Double) -> RGBAImage {
    let gammaCorrection = 1.0 / gamma
    
    func adjustGamma(color: Int) -> Int {
        return Int(255 * pow(Double(color) / 255.0, gammaCorrection))
    }
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            rgbaImage.updatePixel(
                x,
                y: y,
                redFunc: adjustGamma,
                greenFunc: adjustGamma,
                blueFunc: adjustGamma
            )
        }
    }
    return rgbaImage
}

// 7. COLOUR INVERSION
// http://www.dfstudios.co.uk/?page_id=209
public func colourInversion(rgbaImage: RGBAImage) -> RGBAImage {
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            rgbaImage.updatePixel(
                x,
                y: y,
                redFunc: {red in 255 - red},
                greenFunc: {green in 255 - green},
                blueFunc: {blue in 255 - blue}
            )
        }
    }
    return rgbaImage
}

// 8. SOLARISATION
// http://www.dfstudios.co.uk/?page_id=209
// threshold = 128
public func solarisation(rgbaImage: RGBAImage, threshold: Int) -> RGBAImage {

    func useThreshold(color: Int) -> Int {
        if color < threshold {
            return 255 - color
        } else {
            return color
        }
    }
    
    for y in 0..<rgbaImage.height {
        for x in 0..<rgbaImage.width {
            rgbaImage.updatePixel(
                x,
                y: y,
                redFunc: useThreshold,
                greenFunc: useThreshold,
                blueFunc: useThreshold
            )
        }
    }
    return rgbaImage
}