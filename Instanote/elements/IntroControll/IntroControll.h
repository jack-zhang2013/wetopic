#import <UIKit/UIKit.h>
#import "IntroView.h"

@interface IntroControll : UIView<UIScrollViewDelegate> {
    UIImageView *backgroundImage1;
    UIImageView *backgroundImage2;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSArray *pages;
    
    UIButton *startButton;
    
    NSTimer *timer;
    
    int currentPhotoNum;
}

@property (nonatomic, retain)UIButton *startButton;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;


@end
