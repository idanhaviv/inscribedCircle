//
//  ViewController.m
//  InscribedCircle
//
//  Created by Haviv, Idan [ICG-IT] on 1/7/15.
//  Copyright (c) 2015 idan.haviv.org. All rights reserved.
//

#import "ViewController.h"
#import "SHPieChartView.h"

@interface ViewController ()

@property (strong, nonatomic) UIColor *innerCircleColor;
@property (strong, nonatomic) UIColor *boundryCircleColor;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.innerCircleColor = [UIColor blackColor];
    self.boundryCircleColor = [UIColor blueColor];
    UIFont *labelFont = [UIFont systemFontOfSize:14];
    NSDictionary *attributes = @{NSFontAttributeName: labelFont};
    self.label = [[NSAttributedString alloc] initWithString:@"Points" attributes:attributes];
    
    
	self.numberOfCorrectAnswers = 3;
    self.numberOfQuestions = 5;
    
    CGFloat correctAnswersPortion = self.numberOfCorrectAnswers / self.numberOfQuestions;
    SHPieChartView *pieChart = [self concentricPieChart:self.innerCircleColor
                                          boundaryColor:self.boundryCircleColor
                                     progressProportion:correctAnswersPortion];
    pieChart = [self addContentsToPieChart:pieChart label:self.label numberOfPoints:self.numberOfCorrectAnswers rank:self.level color:self.boundryCircleColor];
    
    [self.view addSubview:pieChart];
}

- (SHPieChartView *)addContentsToPieChart:(SHPieChartView *)pieChart label:(NSAttributedString *)text numberOfPoints:(CGFloat)numberOfPoints rank:(NSString *)rank color:(UIColor *)color
{
    CGSize labelSize = text.size;
    CGRect originalBounds = pieChart.bounds;
    CGFloat xValue = CGRectGetMidX(originalBounds) - (0.5 *labelSize.width);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xValue,
                                                               0.6 * (originalBounds.origin.y + originalBounds.size.height),
                                                               labelSize.width,
                                                               labelSize.height)];
    label.attributedText = text;
    label.textColor = color;
    [pieChart addSubview:label];
    
    return pieChart;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (SHPieChartView *)concentricPieChart:(UIColor *)innerColor boundaryColor:(UIColor *)boundaryColor progressProportion:(CGFloat)progressProportion
{
    SHPieChartView *concentricPieChart = [[SHPieChartView alloc] initWithFrame:CGRectMake(10, 10, 140, 140)];
    UIColor *backgroundColor = [self darkerColor:boundaryColor];
    concentricPieChart.chartBackgroundColor = backgroundColor;
    concentricPieChart.isConcentric = YES;
    concentricPieChart.concentricRadius = 55;
    concentricPieChart.concentricColor = innerColor;
    
    [concentricPieChart addAngleValue:progressProportion andColor:boundaryColor];
    
    return concentricPieChart;
}

- (UIColor *)darkerColor:(UIColor *)originalColor
{
    CGFloat hue, saturation, brightness, alpha;
    if ([originalColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue
                          saturation:saturation
                          brightness:brightness * 0.5
                               alpha:alpha];
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
