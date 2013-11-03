//
//  ViewController.m
//  JSCoreTest
//
//  Created by Evgenii Neumerzhitckii on 3/11/2013.
//  Copyright (c) 2013 Evgenii Neumerzhitckii. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()  <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextView *javascriptText;
@property (weak, nonatomic) IBOutlet UITextField *argumentText;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.javascriptText.text = [self loadJsFromFile];
    [self runJavaScript];
}

- (NSString *)loadJsFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"greet" ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}

- (void)runJavaScript
{
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript: self.javascriptText.text];
    JSValue *function = context[@"greet"];
    JSValue* result = [function callWithArguments:@[self.argumentText.text]];
    self.resultLabel.text = [result toString];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self runJavaScript];
}

- (IBAction)argumentValueEditingChanged:(id)sender {
    [self runJavaScript];
}

@end
