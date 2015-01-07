//
//  ViewController.h
//  InscribedCircle
//
//  Created by Haviv, Idan [ICG-IT] on 1/7/15.
//  Copyright (c) 2015 idan.haviv.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) CGFloat numberOfQuestions;
@property (nonatomic) CGFloat numberOfCorrectAnswers;
@property (strong, nonatomic) NSString *level;
@property (strong, nonatomic) NSAttributedString *label;

@end
