//
//  ViewController.m
//  SimVR
//
//  Created by Jessie Deot on 4/16/16.
//  Copyright © 2016 JessieDeot. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

#import "GCSVideoView.h"

@interface ViewController () <GCSVideoViewDelegate>


@end

static const CGFloat kMargin = 16;
static const CGFloat kVideoViewHeight = 250;

@implementation ViewController {
    GCSVideoView *_videoView;
    BOOL _isPaused;
    
}

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Video";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a |GCSVideoView| and position in it in the top half of the view.
    _videoView = [[GCSVideoView alloc]
                  initWithFrame:CGRectMake(16, 32, self.view.bounds.size.width - 32, 200)];
    _videoView.delegate = self;
    _videoView.enableFullscreenButton = YES;
    _videoView.enableCardboardButton = YES;
    
    _isPaused = NO;
    
    //NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"congo" ofType:@"mp4"];
    //[_videoView loadFromUrl:[[NSURL alloc] initFileURLWithPath:videoPath]];
    [_videoView loadFromUrl:[NSURL URLWithString:@"http://download.wavetlan.com/SVV/Media/HTTP/MP4/ConvertedFiles/MediaCoder/MediaCoder_test1_1m9s_AVC_VBR_256kbps_640x480_24fps_MPEG2Layer3_CBR_160kbps_Stereo_22050Hz.mp4"]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _videoView.frame = CGRectMake( 100, 200, _videoView.frame.size.width, _videoView.frame.size.height ); // set new position exactly

    //_videoView.frame = CGRectMake(kMargin, kMargin, CGRectGetWidth(self.view.bounds) - 2 * kMargin, kVideoViewHeight);
}

#pragma mark - GCSVideoViewDelegate

- (void)widgetViewDidTap:(GCSWidgetView *)widgetView {
    if (_isPaused) {
        [_videoView resume];
    } else {
        [_videoView pause];
    }
    _isPaused = !_isPaused;
}

- (void)videoView:(GCSVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Rewind to beginning of the video when it reaches the end.
    if (position == videoView.duration) {
        _isPaused = YES;
        [_videoView seekTo:0];
    }
}
@end

