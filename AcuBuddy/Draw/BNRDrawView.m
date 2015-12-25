//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Eric Mead on 10/3/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "UIKit/UIKit.h"
#import "BNRDrawViewController.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong)   UIPanGestureRecognizer *moveRecognizer;

@property (nonatomic, strong)   NSMutableDictionary *linesInProgress;

@property (nonatomic, strong)   NSMutableArray *finishedLines;

@property (nonatomic, weak)     BNRLine *selectedLine;


@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self) {
        
        //[self setUpdismissButton];
        
        
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor lightGrayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        
        [self addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    
    }
    return self;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

-(void)deleteLine:(id)sender
{
[self.finishedLines removeObject:self.selectedLine];
[self setNeedsDisplay];
}

-(void) doubleTap: (UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeLastObject];
    [self setNeedsDisplay];
}

-(void) longPress: (UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

-(void) tap: (UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 1, 1) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line= [[BNRLine alloc]init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
   
    
    [self setNeedsDisplay];
    
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

-(BNRLine *)lineAtPoint: (CGPoint)p
{
    for (BNRLine *l in self.finishedLines){
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            if (hypot(x-p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    return nil;
}


-(void) strokeLine: (BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

-(void) drawRect: (CGRect)rect
{
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines){
        [self strokeLine:line];
    }
    
    [[UIColor redColor]set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    if (self.selectedLine){
        [[UIColor greenColor]set];
        [self strokeLine:self.selectedLine];
    }
    
}

-(void) moveLine: (UIPanGestureRecognizer *)gr

{
    if(!self.selectedLine){
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [gr translationInView:self];
        
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        
        begin.x += translation.x;
        begin.y += translation.y;
        
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (void) setUpdismissButton {
    
    UIView* dismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    dismissView.backgroundColor = [UIColor redColor];
    
    [self addSubview: dismissView];
    [self bringSubviewToFront: dismissView];
    
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dismissButton setFrame: CGRectMake(0, 0, 50, 50)];
    [dismissButton sizeThatFits:CGSizeMake(40, 40)];
    [dismissButton setTitle:@"x" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [dismissView addSubview: dismissButton];
    
}

-(void) dismissButtonTapped: (UIButton *)button {
    
   
    BNRDrawViewController*c =[[BNRDrawViewController alloc] init];
    [c dismiss];
    
    [self setHidden:YES];
    
}


@end
