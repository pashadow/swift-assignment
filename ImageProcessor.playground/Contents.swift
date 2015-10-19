//: Playground - noun: a place where people can play

import UIKit

// LESSON EXAMPLES

let sample = UIImage(named: "sample")!
//let sample = UIImage(named: "lena.jpg")!
//let sample = UIImage(named: "mandrill.jpg")!

//contrastTransformation1(RGBAImage(image: sample)!).toUIImage()!
//
//contrastTransformation2(RGBAImage(image: sample)!).toUIImage()!
//
//contrastTransformation3(RGBAImage(image: sample)!).toUIImage()!
//
//simpleGreyscaleTransformation(RGBAImage(image: sample)!).toUIImage()!
//
//swapChanels(RGBAImage(image: sample)!, chanels: "RG").toUIImage()!
//
//swapChanels(RGBAImage(image: sample)!, chanels: "GB").toUIImage()!
//
//swapChanels(RGBAImage(image: sample)!, chanels: "RB").toUIImage()!
//
// IMAGE PROCESSING ALGORITHMS
//
//let black	= Pixel(redChanel: 0, greenChanel: 0, blueChanel: 0, alphaChanel: 255)
//let red		= Pixel(redChanel: 255, greenChanel: 0, blueChanel: 0, alphaChanel: 255)
//let green	= Pixel(redChanel: 0, greenChanel: 255, blueChanel: 0, alphaChanel: 255)
//let yellow	= Pixel(redChanel: 255, greenChanel: 255, blueChanel: 0, alphaChanel: 255)
//let blue	= Pixel(redChanel: 0, greenChanel: 0, blueChanel: 255, alphaChanel: 255)
//let magenta	= Pixel(redChanel: 255, greenChanel: 0, blueChanel: 255, alphaChanel: 255)
//let cyan	= Pixel(redChanel: 0, greenChanel: 255, blueChanel: 255, alphaChanel: 255)
//let white	= Pixel(redChanel: 255, greenChanel: 255, blueChanel: 255, alphaChanel: 255)
//let palette = [black, red, green, yellow, blue, magenta, cyan, white]
//
//colorReductionSimple(RGBAImage(image: sample)!, palette: palette).toUIImage()!
//colorReductionDiffusion(RGBAImage(image: sample)!, palette: palette).toUIImage()!
//
//greyscaleConversion(RGBAImage(image: sample)!).toUIImage()!
//
//adjustBrightness(RGBAImage(image: sample)!, brightness: 128).toUIImage()!
//
//adjustContrast(RGBAImage(image: sample)!, contrast: -128).toUIImage()!
//
//adjustGamma(RGBAImage(image: sample)!, gamma: 2.5).toUIImage()!
//
//colourInversion(RGBAImage(image: sample)!).toUIImage()!
//
//solarisation(RGBAImage(image: sample)!, threshold: 128).toUIImage()!

ImageProcessor(image: sample, filters: [FilterColorReductionDefault(), FilterGreyscale(), FilterAdjustBrightness128(), FilterAdjustContrast128(), FilterColorInversion()]).toUIImage()

var im = ImageProcessor(image: sample)
im.apply("Brightness128")
im.toUIImage()
