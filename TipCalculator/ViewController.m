//
//  ViewController.m
//  TipCalculator
//
//  Created by Sanjay Shah on 2017-10-13.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;

@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;

@property float defaultTip;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipPercentageTextField.delegate = self;
    self.billAmountTextField.delegate = self;
    
    self.defaultTip = 15.0;
 
}

- (IBAction)tipSlider:(UISlider *)sender {
    
    float tipAmount = sender.value;
    
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.02f", tipAmount];
    
    [self autoCalculateTip];
    
    
}



- (IBAction)calculateTip:(UIButton *)sender {
    
    [self autoCalculateTip];
 
    //make keyboard disappear
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
}


-(void) autoCalculateTip {
    
    if (self.tipPercentageTextField.text.length < 1){
        
        float billAmount = [self.billAmountTextField.text floatValue];
        float tipAmount = (billAmount * (self.defaultTip/100));
        
        self.tipPercentageLabel.text = [NSString stringWithFormat:@"$%.02f", tipAmount];
    }
    
    else{
        
        float billAmount = [self.billAmountTextField.text floatValue];
        float tipPercent = [self.tipPercentageTextField.text floatValue];
        
        float tipAmount = (billAmount * (tipPercent/100));
        
        self.tipPercentageLabel.text = [NSString stringWithFormat:@"$%.02f", tipAmount];
    }
    
}

-(void) billAmountTextFieldDidBeginEditing: (UITextField*) billAmountTextField {
    
    if (self.billAmountTextField.isFirstResponder == true) {
        billAmountTextField.placeholder = nil;

    }
}

-(void) tipPercentageTextFieldDidBeginEditing: (UITextField*) tipPercentageTextField {
    
    if (self.tipPercentageTextField.isFirstResponder == true) {
        tipPercentageTextField.placeholder = nil;
    }
}


// fires when the return key is tapped which allows us to respond accordingly
-(BOOL) textFieldShouldReturn:(UITextField*)  textField {
    
    [textField resignFirstResponder];
    [self autoCalculateTip];
    
    return true;
}


// fires when the clear button is about to fire
- (BOOL)textFieldShouldClear:(UITextField *) textField {
    
    if (textField == self.tipPercentageTextField)
    {
        NSLog(@"In textFieldShouldClear:");
        self.defaultTip = 15.0;
        textField.text = @"";
        //    [self.tipPercentageTextField.text isEqualToString:@""];
        //    [self.billAmountTextField.text isEqualToString:@""];
    }
    [self autoCalculateTip];
    
    return true;
}



-(void) clearAllFields{
    self.billAmountTextField.text = @"";
    self.tipPercentageTextField.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
