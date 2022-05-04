//
//  SecondCell.m
//  forealer
//
//  Created by Misha Causur on 04.05.2022.
//

#import "SecondCell.h"

@implementation SecondCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    if (self = [super initWithTitle:LocStr(@"CONTAINER_LIST_TITLE") navBarHidden:NO]) {
        m_paths = [ContainerList shared].paths;

        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(onContainerListDidChange)
            name:kSDKLauncherContainerListDidChange object:nil];
    }

    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
}

@end
