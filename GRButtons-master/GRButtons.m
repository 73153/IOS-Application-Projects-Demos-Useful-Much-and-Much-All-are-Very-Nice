//
//  GRButtons.m
//  MTStrategy
//
//  Created by Göncz Róbert on 11/28/12.
//  Copyright (c) 2012 Göncz Róbert. All rights reserved.
//

#import "GRButtons.h"

UIBezierPath *FacebookPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*287.94, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*128, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*128, p*167.77)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*167.75)];
    [bezierPath addLineToPoint: CGPointMake(p*191.9, p*115.77)];
    [bezierPath addCurveToPoint: CGPointMake(p*296.19, p*-0) controlPoint1: CGPointMake(p*191.9, p*43.79) controlPoint2: CGPointMake(p*211.41, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*366.78, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*366.78, p*88.24)];
    [bezierPath addLineToPoint: CGPointMake(p*322.67, p*88.24)];
    [bezierPath addCurveToPoint: CGPointMake(p*288.06, p*123.58) controlPoint1: CGPointMake(p*289.65, p*88.24) controlPoint2: CGPointMake(p*288.06, p*100.57)];
    [bezierPath addLineToPoint: CGPointMake(p*287.93, p*167.75)];
    [bezierPath addLineToPoint: CGPointMake(p*367.28, p*167.75)];
    [bezierPath addLineToPoint: CGPointMake(p*357.93, p*255.97)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*287.94, p*512)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *FacebookRectPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    /// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*426.67, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.34) controlPoint1: CGPointMake(p*38.41, p*-0) controlPoint2: CGPointMake(p*0, p*38.41)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*0, p*473.63) controlPoint2: CGPointMake(p*38.41, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.67, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.66) controlPoint1: CGPointMake(p*473.61, p*512) controlPoint2: CGPointMake(p*512, p*473.63)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.34)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.67, p*-0) controlPoint1: CGPointMake(p*512, p*38.41) controlPoint2: CGPointMake(p*473.61, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*435.3, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*480)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*480)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*209.74, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*209.74, p*182.72)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*182.72)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*135.12)];
    [bezierPath addCurveToPoint: CGPointMake(p*359.94, p*32) controlPoint1: CGPointMake(p*256, p*70.45) controlPoint2: CGPointMake(p*283.9, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*447.56, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*447.56, p*111.28)];
    [bezierPath addLineToPoint: CGPointMake(p*375.99, p*111.28)];
    [bezierPath addCurveToPoint: CGPointMake(p*352.12, p*143.04) controlPoint1: CGPointMake(p*354.75, p*111.25) controlPoint2: CGPointMake(p*352.12, p*122.36)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*182.72)];
    [bezierPath addLineToPoint: CGPointMake(p*448, p*182.72)];
    [bezierPath addLineToPoint: CGPointMake(p*435.3, p*256)];
    [bezierPath closePath];
    
    return bezierPath;
}



UIBezierPath *FacebookCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*192, p*503.94) controlPoint1: CGPointMake(p*0, p*375.28) controlPoint2: CGPointMake(p*81.58, p*475.52)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*288)];
    [bezierPath addLineToPoint: CGPointMake(p*145.74, p*288)];
    [bezierPath addLineToPoint: CGPointMake(p*145.74, p*214.72)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*214.72)];
    [bezierPath addLineToPoint: CGPointMake(p*192, p*167.12)];
    [bezierPath addCurveToPoint: CGPointMake(p*295.94, p*64) controlPoint1: CGPointMake(p*192, p*102.45) controlPoint2: CGPointMake(p*219.9, p*64)];
    [bezierPath addLineToPoint: CGPointMake(p*383.56, p*64)];
    [bezierPath addLineToPoint: CGPointMake(p*383.56, p*143.28)];
    [bezierPath addLineToPoint: CGPointMake(p*311.99, p*143.28)];
    [bezierPath addCurveToPoint: CGPointMake(p*288.12, p*175.04) controlPoint1: CGPointMake(p*290.75, p*143.25) controlPoint2: CGPointMake(p*288.12, p*154.36)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*214.72)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*214.72)];
    [bezierPath addLineToPoint: CGPointMake(p*371.3, p*288)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*288)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*510.01)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*414.28, p*494.26) controlPoint2: CGPointMake(p*512, p*386.55)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *TwitterPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*512, p*97.21)];
    [bezierPath addCurveToPoint: CGPointMake(p*451.67, p*113.75) controlPoint1: CGPointMake(p*493.16, p*105.56) controlPoint2: CGPointMake(p*472.92, p*111.21)];
    [bezierPath addCurveToPoint: CGPointMake(p*497.86, p*55.63) controlPoint1: CGPointMake(p*473.36, p*100.75) controlPoint2: CGPointMake(p*490.01, p*80.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*431.15, p*81.12) controlPoint1: CGPointMake(p*477.56, p*67.67) controlPoint2: CGPointMake(p*455.08, p*76.41)];
    [bezierPath addCurveToPoint: CGPointMake(p*354.48, p*47.95) controlPoint1: CGPointMake(p*411.99, p*60.71) controlPoint2: CGPointMake(p*384.69, p*47.95)];
    [bezierPath addCurveToPoint: CGPointMake(p*249.43, p*152.99) controlPoint1: CGPointMake(p*296.47, p*47.95) controlPoint2: CGPointMake(p*249.43, p*94.98)];
    [bezierPath addCurveToPoint: CGPointMake(p*252.15, p*176.93) controlPoint1: CGPointMake(p*249.43, p*161.23) controlPoint2: CGPointMake(p*250.36, p*169.24)];
    [bezierPath addCurveToPoint: CGPointMake(p*35.65, p*67.18) controlPoint1: CGPointMake(p*164.85, p*172.55) controlPoint2: CGPointMake(p*87.45, p*130.73)];
    [bezierPath addCurveToPoint: CGPointMake(p*21.42, p*119.99) controlPoint1: CGPointMake(p*26.6, p*82.69) controlPoint2: CGPointMake(p*21.42, p*100.74)];
    [bezierPath addCurveToPoint: CGPointMake(p*68.15, p*207.42) controlPoint1: CGPointMake(p*21.42, p*156.43) controlPoint2: CGPointMake(p*39.97, p*188.58)];
    [bezierPath addCurveToPoint: CGPointMake(p*20.58, p*194.28) controlPoint1: CGPointMake(p*50.93, p*206.88) controlPoint2: CGPointMake(p*34.74, p*202.15)];
    [bezierPath addCurveToPoint: CGPointMake(p*20.57, p*195.6) controlPoint1: CGPointMake(p*20.57, p*194.72) controlPoint2: CGPointMake(p*20.57, p*195.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*104.83, p*298.6) controlPoint1: CGPointMake(p*20.57, p*246.5) controlPoint2: CGPointMake(p*56.77, p*288.95)];
    [bezierPath addCurveToPoint: CGPointMake(p*77.15, p*302.29) controlPoint1: CGPointMake(p*96.01, p*301) controlPoint2: CGPointMake(p*86.73, p*302.29)];
    [bezierPath addCurveToPoint: CGPointMake(p*57.39, p*300.4) controlPoint1: CGPointMake(p*70.38, p*302.29) controlPoint2: CGPointMake(p*63.8, p*301.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*155.51, p*373.35) controlPoint1: CGPointMake(p*70.76, p*342.13) controlPoint2: CGPointMake(p*109.55, p*372.51)];
    [bezierPath addCurveToPoint: CGPointMake(p*25.06, p*418.32) controlPoint1: CGPointMake(p*119.56, p*401.53) controlPoint2: CGPointMake(p*74.27, p*418.32)];
    [bezierPath addCurveToPoint: CGPointMake(p*-0, p*416.85) controlPoint1: CGPointMake(p*16.58, p*418.32) controlPoint2: CGPointMake(p*8.22, p*417.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*161.02, p*464.04) controlPoint1: CGPointMake(p*46.48, p*446.65) controlPoint2: CGPointMake(p*101.7, p*464.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*459.89, p*165.17) controlPoint1: CGPointMake(p*354.23, p*464.04) controlPoint2: CGPointMake(p*459.89, p*303.98)];
    [bezierPath addCurveToPoint: CGPointMake(p*459.58, p*151.58) controlPoint1: CGPointMake(p*459.89, p*160.62) controlPoint2: CGPointMake(p*459.78, p*156.09)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*97.21) controlPoint1: CGPointMake(p*480.11, p*136.77) controlPoint2: CGPointMake(p*497.92, p*118.27)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *TwitterRectPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*426.67, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.35) controlPoint1: CGPointMake(p*38.41, p*-0) controlPoint2: CGPointMake(p*0, p*38.4)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*0, p*473.62) controlPoint2: CGPointMake(p*38.41, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.67, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.65) controlPoint1: CGPointMake(p*473.61, p*512) controlPoint2: CGPointMake(p*512, p*473.62)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.67, p*-0) controlPoint1: CGPointMake(p*512, p*38.4) controlPoint2: CGPointMake(p*473.61, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*419.03, p*170.92)];
    [bezierPath addCurveToPoint: CGPointMake(p*419.27, p*181.99) controlPoint1: CGPointMake(p*419.19, p*174.59) controlPoint2: CGPointMake(p*419.27, p*178.28)];
    [bezierPath addCurveToPoint: CGPointMake(p*179.94, p*425.52) controlPoint1: CGPointMake(p*419.27, p*295.1) controlPoint2: CGPointMake(p*334.66, p*425.52)];
    [bezierPath addCurveToPoint: CGPointMake(p*51, p*387.07) controlPoint1: CGPointMake(p*132.44, p*425.52) controlPoint2: CGPointMake(p*88.23, p*411.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*71.06, p*388.26) controlPoint1: CGPointMake(p*57.58, p*387.86) controlPoint2: CGPointMake(p*64.27, p*388.26)];
    [bezierPath addCurveToPoint: CGPointMake(p*175.53, p*351.62) controlPoint1: CGPointMake(p*110.47, p*388.26) controlPoint2: CGPointMake(p*146.74, p*374.58)];
    [bezierPath addCurveToPoint: CGPointMake(p*96.95, p*292.18) controlPoint1: CGPointMake(p*138.72, p*350.93) controlPoint2: CGPointMake(p*107.66, p*326.18)];
    [bezierPath addCurveToPoint: CGPointMake(p*112.78, p*293.72) controlPoint1: CGPointMake(p*102.09, p*293.18) controlPoint2: CGPointMake(p*107.36, p*293.72)];
    [bezierPath addCurveToPoint: CGPointMake(p*134.94, p*290.71) controlPoint1: CGPointMake(p*120.45, p*293.72) controlPoint2: CGPointMake(p*127.88, p*292.67)];
    [bezierPath addCurveToPoint: CGPointMake(p*67.47, p*206.79) controlPoint1: CGPointMake(p*96.46, p*282.85) controlPoint2: CGPointMake(p*67.47, p*248.26)];
    [bezierPath addCurveToPoint: CGPointMake(p*67.47, p*205.71) controlPoint1: CGPointMake(p*67.47, p*206.42) controlPoint2: CGPointMake(p*67.47, p*206.07)];
    [bezierPath addCurveToPoint: CGPointMake(p*105.57, p*216.41) controlPoint1: CGPointMake(p*78.81, p*212.12) controlPoint2: CGPointMake(p*91.78, p*215.97)];
    [bezierPath addCurveToPoint: CGPointMake(p*68.15, p*145.17) controlPoint1: CGPointMake(p*83, p*201.07) controlPoint2: CGPointMake(p*68.15, p*174.87)];
    [bezierPath addCurveToPoint: CGPointMake(p*79.54, p*102.14) controlPoint1: CGPointMake(p*68.15, p*129.49) controlPoint2: CGPointMake(p*72.3, p*114.78)];
    [bezierPath addCurveToPoint: CGPointMake(p*252.92, p*191.57) controlPoint1: CGPointMake(p*121.03, p*153.93) controlPoint2: CGPointMake(p*183.01, p*188)];
    [bezierPath addCurveToPoint: CGPointMake(p*250.74, p*172.07) controlPoint1: CGPointMake(p*251.48, p*185.31) controlPoint2: CGPointMake(p*250.74, p*178.77)];
    [bezierPath addCurveToPoint: CGPointMake(p*334.85, p*86.48) controlPoint1: CGPointMake(p*250.74, p*124.8) controlPoint2: CGPointMake(p*288.4, p*86.48)];
    [bezierPath addCurveToPoint: CGPointMake(p*396.25, p*113.5) controlPoint1: CGPointMake(p*359.05, p*86.48) controlPoint2: CGPointMake(p*380.91, p*96.87)];
    [bezierPath addCurveToPoint: CGPointMake(p*449.67, p*92.73) controlPoint1: CGPointMake(p*415.42, p*109.67) controlPoint2: CGPointMake(p*433.42, p*102.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*412.69, p*140.09) controlPoint1: CGPointMake(p*443.39, p*112.72) controlPoint2: CGPointMake(p*430.05, p*129.49)];
    [bezierPath addCurveToPoint: CGPointMake(p*461, p*126.61) controlPoint1: CGPointMake(p*429.7, p*138.02) controlPoint2: CGPointMake(p*445.91, p*133.42)];
    [bezierPath addCurveToPoint: CGPointMake(p*419.03, p*170.92) controlPoint1: CGPointMake(p*449.73, p*143.77) controlPoint2: CGPointMake(p*435.46, p*158.85)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *TwitterCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.62, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*403.12, p*180.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*403.34, p*190.36) controlPoint1: CGPointMake(p*403.27, p*183.8) controlPoint2: CGPointMake(p*403.34, p*187.07)];
    [bezierPath addCurveToPoint: CGPointMake(p*187.36, p*406.35) controlPoint1: CGPointMake(p*403.34, p*290.67) controlPoint2: CGPointMake(p*326.99, p*406.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*71, p*372.24) controlPoint1: CGPointMake(p*144.49, p*406.35) controlPoint2: CGPointMake(p*104.59, p*393.78)];
    [bezierPath addCurveToPoint: CGPointMake(p*89.11, p*373.3) controlPoint1: CGPointMake(p*76.94, p*372.94) controlPoint2: CGPointMake(p*82.98, p*373.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*183.38, p*340.8) controlPoint1: CGPointMake(p*124.67, p*373.3) controlPoint2: CGPointMake(p*157.4, p*361.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*112.47, p*288.09) controlPoint1: CGPointMake(p*150.17, p*340.19) controlPoint2: CGPointMake(p*122.13, p*318.24)];
    [bezierPath addCurveToPoint: CGPointMake(p*126.75, p*289.45) controlPoint1: CGPointMake(p*117.11, p*288.97) controlPoint2: CGPointMake(p*121.86, p*289.45)];
    [bezierPath addCurveToPoint: CGPointMake(p*146.75, p*286.79) controlPoint1: CGPointMake(p*133.68, p*289.45) controlPoint2: CGPointMake(p*140.38, p*288.52)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.86, p*212.35) controlPoint1: CGPointMake(p*112.03, p*279.81) controlPoint2: CGPointMake(p*85.86, p*249.13)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.87, p*211.4) controlPoint1: CGPointMake(p*85.86, p*212.03) controlPoint2: CGPointMake(p*85.86, p*211.71)];
    [bezierPath addCurveToPoint: CGPointMake(p*120.25, p*220.89) controlPoint1: CGPointMake(p*96.1, p*217.08) controlPoint2: CGPointMake(p*107.81, p*220.5)];
    [bezierPath addCurveToPoint: CGPointMake(p*86.48, p*157.71) controlPoint1: CGPointMake(p*99.88, p*207.28) controlPoint2: CGPointMake(p*86.48, p*184.05)];
    [bezierPath addCurveToPoint: CGPointMake(p*96.76, p*119.55) controlPoint1: CGPointMake(p*86.48, p*143.8) controlPoint2: CGPointMake(p*90.22, p*130.76)];
    [bezierPath addCurveToPoint: CGPointMake(p*253.22, p*198.86) controlPoint1: CGPointMake(p*134.2, p*165.47) controlPoint2: CGPointMake(p*190.13, p*195.69)];
    [bezierPath addCurveToPoint: CGPointMake(p*251.25, p*181.56) controlPoint1: CGPointMake(p*251.93, p*193.3) controlPoint2: CGPointMake(p*251.25, p*187.51)];
    [bezierPath addCurveToPoint: CGPointMake(p*327.16, p*105.65) controlPoint1: CGPointMake(p*251.25, p*139.64) controlPoint2: CGPointMake(p*285.24, p*105.65)];
    [bezierPath addCurveToPoint: CGPointMake(p*382.57, p*129.62) controlPoint1: CGPointMake(p*349, p*105.65) controlPoint2: CGPointMake(p*368.73, p*114.87)];
    [bezierPath addCurveToPoint: CGPointMake(p*430.78, p*111.2) controlPoint1: CGPointMake(p*399.86, p*126.22) controlPoint2: CGPointMake(p*416.11, p*119.9)];
    [bezierPath addCurveToPoint: CGPointMake(p*397.4, p*153.2) controlPoint1: CGPointMake(p*425.11, p*128.93) controlPoint2: CGPointMake(p*413.07, p*143.81)];
    [bezierPath addCurveToPoint: CGPointMake(p*441, p*141.25) controlPoint1: CGPointMake(p*412.76, p*151.37) controlPoint2: CGPointMake(p*427.39, p*147.28)];
    [bezierPath addCurveToPoint: CGPointMake(p*403.12, p*180.54) controlPoint1: CGPointMake(p*430.82, p*156.47) controlPoint2: CGPointMake(p*417.95, p*169.84)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *GooglePlusPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*279.53, p*32)];
    [bezierPath addCurveToPoint: CGPointMake(p*145.56, p*32) controlPoint1: CGPointMake(p*279.53, p*32) controlPoint2: CGPointMake(p*179.06, p*32)];
    [bezierPath addCurveToPoint: CGPointMake(p*28.98, p*130.21) controlPoint1: CGPointMake(p*85.5, p*32) controlPoint2: CGPointMake(p*28.98, p*77.5)];
    [bezierPath addCurveToPoint: CGPointMake(p*131.02, p*227.54) controlPoint1: CGPointMake(p*28.98, p*184.07) controlPoint2: CGPointMake(p*69.92, p*227.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*143.44, p*227.17) controlPoint1: CGPointMake(p*135.27, p*227.54) controlPoint2: CGPointMake(p*139.4, p*227.46)];
    [bezierPath addCurveToPoint: CGPointMake(p*136.64, p*252.19) controlPoint1: CGPointMake(p*139.48, p*234.76) controlPoint2: CGPointMake(p*136.64, p*243.31)];
    [bezierPath addCurveToPoint: CGPointMake(p*154.88, p*289.2) controlPoint1: CGPointMake(p*136.64, p*267.16) controlPoint2: CGPointMake(p*144.69, p*279.29)];
    [bezierPath addCurveToPoint: CGPointMake(p*131.65, p*289.43) controlPoint1: CGPointMake(p*147.18, p*289.2) controlPoint2: CGPointMake(p*139.75, p*289.43)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*385.94) controlPoint1: CGPointMake(p*57.26, p*289.42) controlPoint2: CGPointMake(p*0, p*336.8)];
    [bezierPath addCurveToPoint: CGPointMake(p*137.17, p*464.59) controlPoint1: CGPointMake(p*0, p*434.32) controlPoint2: CGPointMake(p*62.77, p*464.59)];
    [bezierPath addCurveToPoint: CGPointMake(p*268.82, p*368.08) controlPoint1: CGPointMake(p*221.98, p*464.59) controlPoint2: CGPointMake(p*268.82, p*416.47)];
    [bezierPath addCurveToPoint: CGPointMake(p*221.98, p*281.01) controlPoint1: CGPointMake(p*268.82, p*329.28) controlPoint2: CGPointMake(p*257.37, p*306.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*186.71, p*239.34) controlPoint1: CGPointMake(p*209.87, p*272.44) controlPoint2: CGPointMake(p*186.71, p*251.59)];
    [bezierPath addCurveToPoint: CGPointMake(p*212.43, p*201.02) controlPoint1: CGPointMake(p*186.71, p*224.98) controlPoint2: CGPointMake(p*190.81, p*217.9)];
    [bezierPath addCurveToPoint: CGPointMake(p*250.26, p*131.06) controlPoint1: CGPointMake(p*234.58, p*183.7) controlPoint2: CGPointMake(p*250.26, p*159.36)];
    [bezierPath addCurveToPoint: CGPointMake(p*207.08, p*53.67) controlPoint1: CGPointMake(p*250.26, p*97.35) controlPoint2: CGPointMake(p*235.25, p*64.51)];
    [bezierPath addLineToPoint: CGPointMake(p*249.55, p*53.67)];
    [bezierPath addLineToPoint: CGPointMake(p*279.53, p*32)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*232.74, p*359.73)];
    [bezierPath addCurveToPoint: CGPointMake(p*234.38, p*373.54) controlPoint1: CGPointMake(p*233.8, p*364.21) controlPoint2: CGPointMake(p*234.38, p*368.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*136.9, p*443.2) controlPoint1: CGPointMake(p*234.38, p*412.64) controlPoint2: CGPointMake(p*209.19, p*443.2)];
    [bezierPath addCurveToPoint: CGPointMake(p*48.34, p*371.55) controlPoint1: CGPointMake(p*85.47, p*443.2) controlPoint2: CGPointMake(p*48.34, p*410.65)];
    [bezierPath addCurveToPoint: CGPointMake(p*145.82, p*301.88) controlPoint1: CGPointMake(p*48.34, p*333.23) controlPoint2: CGPointMake(p*94.4, p*301.33)];
    [bezierPath addCurveToPoint: CGPointMake(p*179.15, p*307.23) controlPoint1: CGPointMake(p*157.82, p*302.01) controlPoint2: CGPointMake(p*169, p*303.94)];
    [bezierPath addCurveToPoint: CGPointMake(p*232.74, p*359.73) controlPoint1: CGPointMake(p*207.07, p*326.64) controlPoint2: CGPointMake(p*227.09, p*337.61)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*150.41, p*213.89)];
    [bezierPath addCurveToPoint: CGPointMake(p*77.13, p*129.96) controlPoint1: CGPointMake(p*115.89, p*212.86) controlPoint2: CGPointMake(p*83.09, p*175.27)];
    [bezierPath addCurveToPoint: CGPointMake(p*128.83, p*50.96) controlPoint1: CGPointMake(p*71.17, p*84.62) controlPoint2: CGPointMake(p*94.32, p*49.94)];
    [bezierPath addCurveToPoint: CGPointMake(p*202.11, p*133.69) controlPoint1: CGPointMake(p*163.33, p*52) controlPoint2: CGPointMake(p*196.15, p*88.37)];
    [bezierPath addCurveToPoint: CGPointMake(p*150.41, p*213.89) controlPoint1: CGPointMake(p*208.06, p*179.02) controlPoint2: CGPointMake(p*184.91, p*214.92)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*416, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*128)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *GooglePlusRectanglePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*0.4, p*434.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*0.11, p*431.02) controlPoint1: CGPointMake(p*0.28, p*433.57) controlPoint2: CGPointMake(p*0.18, p*432.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*0.4, p*434.83) controlPoint1: CGPointMake(p*0.18, p*432.3) controlPoint2: CGPointMake(p*0.28, p*433.57)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*117.95, p*282.57)];
    [bezierPath addCurveToPoint: CGPointMake(p*186.88, p*175.98) controlPoint1: CGPointMake(p*163.96, p*283.94) controlPoint2: CGPointMake(p*194.82, p*236.23)];
    [bezierPath addCurveToPoint: CGPointMake(p*89.18, p*66.01) controlPoint1: CGPointMake(p*178.94, p*115.74) controlPoint2: CGPointMake(p*135.19, p*67.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*20.25, p*171.01) controlPoint1: CGPointMake(p*43.17, p*64.65) controlPoint2: CGPointMake(p*12.31, p*110.75)];
    [bezierPath addCurveToPoint: CGPointMake(p*117.95, p*282.57) controlPoint1: CGPointMake(p*28.2, p*231.25) controlPoint2: CGPointMake(p*71.93, p*281.2)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*512, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.67, p*-0) controlPoint1: CGPointMake(p*512, p*38.4) controlPoint2: CGPointMake(p*473.61, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0.06, p*82.96) controlPoint1: CGPointMake(p*39.2, p*-0) controlPoint2: CGPointMake(p*1.34, p*37.12)];
    [bezierPath addCurveToPoint: CGPointMake(p*111.5, p*35.81) controlPoint1: CGPointMake(p*29.24, p*57.27) controlPoint2: CGPointMake(p*69.72, p*35.81)];
    [bezierPath addCurveToPoint: CGPointMake(p*290.12, p*35.81) controlPoint1: CGPointMake(p*156.15, p*35.81) controlPoint2: CGPointMake(p*290.12, p*35.81)];
    [bezierPath addLineToPoint: CGPointMake(p*250.15, p*69.61)];
    [bezierPath addLineToPoint: CGPointMake(p*193.51, p*69.61)];
    [bezierPath addCurveToPoint: CGPointMake(p*251.09, p*172.48) controlPoint1: CGPointMake(p*231.08, p*84.02) controlPoint2: CGPointMake(p*251.09, p*127.68)];
    [bezierPath addCurveToPoint: CGPointMake(p*200.65, p*265.46) controlPoint1: CGPointMake(p*251.09, p*210.1) controlPoint2: CGPointMake(p*230.19, p*242.45)];
    [bezierPath addCurveToPoint: CGPointMake(p*166.36, p*316.4) controlPoint1: CGPointMake(p*171.82, p*287.91) controlPoint2: CGPointMake(p*166.36, p*297.31)];
    [bezierPath addCurveToPoint: CGPointMake(p*213.38, p*371.79) controlPoint1: CGPointMake(p*166.36, p*332.69) controlPoint2: CGPointMake(p*197.23, p*360.4)];
    [bezierPath addCurveToPoint: CGPointMake(p*275.83, p*487.52) controlPoint1: CGPointMake(p*260.57, p*405.06) controlPoint2: CGPointMake(p*275.83, p*435.95)];
    [bezierPath addCurveToPoint: CGPointMake(p*272.8, p*512) controlPoint1: CGPointMake(p*275.83, p*495.73) controlPoint2: CGPointMake(p*274.81, p*503.94)];
    [bezierPath addLineToPoint: CGPointMake(p*426.67, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.65) controlPoint1: CGPointMake(p*473.61, p*512) controlPoint2: CGPointMake(p*512, p*473.62)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*32)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*128)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*92.94, p*382.97)];
    [bezierPath addCurveToPoint: CGPointMake(p*123.91, p*382.67) controlPoint1: CGPointMake(p*103.75, p*382.97) controlPoint2: CGPointMake(p*113.65, p*382.67)];
    [bezierPath addCurveToPoint: CGPointMake(p*99.6, p*333.48) controlPoint1: CGPointMake(p*110.34, p*369.51) controlPoint2: CGPointMake(p*99.6, p*353.37)];
    [bezierPath addCurveToPoint: CGPointMake(p*108.66, p*300.22) controlPoint1: CGPointMake(p*99.6, p*321.68) controlPoint2: CGPointMake(p*103.38, p*310.31)];
    [bezierPath addCurveToPoint: CGPointMake(p*92.1, p*300.72) controlPoint1: CGPointMake(p*103.27, p*300.61) controlPoint2: CGPointMake(p*97.77, p*300.72)];
    [bezierPath addCurveToPoint: CGPointMake(p*-0, p*268.79) controlPoint1: CGPointMake(p*54.92, p*300.72) controlPoint2: CGPointMake(p*23.35, p*288.68)];
    [bezierPath addLineToPoint: CGPointMake(p*-0, p*302.41)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*403.28)];
    [bezierPath addCurveToPoint: CGPointMake(p*92.94, p*382.97) controlPoint1: CGPointMake(p*26.72, p*390.59) controlPoint2: CGPointMake(p*58.45, p*382.97)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*1.71, p*443.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*0.44, p*435.31) controlPoint1: CGPointMake(p*1.15, p*440.9) controlPoint2: CGPointMake(p*0.73, p*438.13)];
    [bezierPath addCurveToPoint: CGPointMake(p*1.71, p*443.63) controlPoint1: CGPointMake(p*0.73, p*438.13) controlPoint2: CGPointMake(p*1.15, p*440.9)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*227.72, p*476.42)];
    [bezierPath addCurveToPoint: CGPointMake(p*156.28, p*406.64) controlPoint1: CGPointMake(p*220.2, p*447.02) controlPoint2: CGPointMake(p*193.5, p*432.44)];
    [bezierPath addCurveToPoint: CGPointMake(p*111.83, p*399.54) controlPoint1: CGPointMake(p*142.75, p*402.27) controlPoint2: CGPointMake(p*127.83, p*399.7)];
    [bezierPath addCurveToPoint: CGPointMake(p*1.73, p*443.72) controlPoint1: CGPointMake(p*67.03, p*399.05) controlPoint2: CGPointMake(p*25.28, p*417.01)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*9.69, p*482.57) controlPoint2: CGPointMake(p*44.24, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*228.56, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*229.91, p*494.78) controlPoint1: CGPointMake(p*229.47, p*506.44) controlPoint2: CGPointMake(p*229.91, p*500.68)];
    [bezierPath addCurveToPoint: CGPointMake(p*227.72, p*476.42) controlPoint1: CGPointMake(p*229.91, p*488.52) controlPoint2: CGPointMake(p*229.15, p*482.39)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *GooglePlusCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*209.3, p*334.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*202.45, p*329.36) controlPoint1: CGPointMake(p*207.1, p*332.63) controlPoint2: CGPointMake(p*204.81, p*331.03)];
    [bezierPath addCurveToPoint: CGPointMake(p*180.81, p*326.05) controlPoint1: CGPointMake(p*195.56, p*327.24) controlPoint2: CGPointMake(p*188.29, p*326.13)];
    [bezierPath addCurveToPoint: CGPointMake(p*179.88, p*326.04) controlPoint1: CGPointMake(p*180.5, p*326.04) controlPoint2: CGPointMake(p*180.19, p*326.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*114.76, p*371.63) controlPoint1: CGPointMake(p*145.19, p*326.04) controlPoint2: CGPointMake(p*114.76, p*347.34)];
    [bezierPath addCurveToPoint: CGPointMake(p*173.95, p*418.78) controlPoint1: CGPointMake(p*114.76, p*398.07) controlPoint2: CGPointMake(p*140.76, p*418.78)];
    [bezierPath addCurveToPoint: CGPointMake(p*226.8, p*405.02) controlPoint1: CGPointMake(p*198.07, p*418.78) controlPoint2: CGPointMake(p*215.85, p*414.15)];
    [bezierPath addCurveToPoint: CGPointMake(p*240.11, p*373.21) controlPoint1: CGPointMake(p*235.76, p*397.55) controlPoint2: CGPointMake(p*240.11, p*387.15)];
    [bezierPath addCurveToPoint: CGPointMake(p*239.11, p*364.54) controlPoint1: CGPointMake(p*240.11, p*370.36) controlPoint2: CGPointMake(p*239.77, p*367.44)];
    [bezierPath addCurveToPoint: CGPointMake(p*209.3, p*334.16) controlPoint1: CGPointMake(p*236.27, p*353.36) controlPoint2: CGPointMake(p*226.93, p*346.43)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.62, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*256.81, p*429.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*174.16, p*455.85) controlPoint1: CGPointMake(p*236.01, p*446.75) controlPoint2: CGPointMake(p*207.43, p*455.85)];
    [bezierPath addCurveToPoint: CGPointMake(p*93.92, p*437.69) controlPoint1: CGPointMake(p*143.47, p*455.85) controlPoint2: CGPointMake(p*114.97, p*449.4)];
    [bezierPath addCurveToPoint: CGPointMake(p*57, p*383.1) controlPoint1: CGPointMake(p*70.11, p*424.45) controlPoint2: CGPointMake(p*57, p*405.06)];
    [bezierPath addCurveToPoint: CGPointMake(p*90.49, p*322.01) controlPoint1: CGPointMake(p*57, p*360.83) controlPoint2: CGPointMake(p*69.21, p*338.57)];
    [bezierPath addCurveToPoint: CGPointMake(p*168.45, p*296.11) controlPoint1: CGPointMake(p*111.63, p*305.57) controlPoint2: CGPointMake(p*139.27, p*296.4)];
    [bezierPath addCurveToPoint: CGPointMake(p*163.75, p*276.4) controlPoint1: CGPointMake(p*165.33, p*289.75) controlPoint2: CGPointMake(p*163.75, p*283.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*164.8, p*266.64) controlPoint1: CGPointMake(p*163.75, p*273.19) controlPoint2: CGPointMake(p*164.1, p*269.93)];
    [bezierPath addCurveToPoint: CGPointMake(p*104.51, p*241.08) controlPoint1: CGPointMake(p*141.24, p*265.62) controlPoint2: CGPointMake(p*119.97, p*256.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*79.64, p*179.09) controlPoint1: CGPointMake(p*88.47, p*224.95) controlPoint2: CGPointMake(p*79.64, p*202.94)];
    [bezierPath addCurveToPoint: CGPointMake(p*111.12, p*116.52) controlPoint1: CGPointMake(p*79.64, p*156.28) controlPoint2: CGPointMake(p*91.11, p*133.48)];
    [bezierPath addCurveToPoint: CGPointMake(p*180.72, p*90.74) controlPoint1: CGPointMake(p*130.44, p*100.13) controlPoint2: CGPointMake(p*155.81, p*90.74)];
    [bezierPath addLineToPoint: CGPointMake(p*322.77, p*90.74)];
    [bezierPath addLineToPoint: CGPointMake(p*289.26, p*128.03)];
    [bezierPath addLineToPoint: CGPointMake(p*256.95, p*128.03)];
    [bezierPath addCurveToPoint: CGPointMake(p*272.52, p*179.77) controlPoint1: CGPointMake(p*266.81, p*141.37) controlPoint2: CGPointMake(p*272.52, p*159.53)];
    [bezierPath addCurveToPoint: CGPointMake(p*239.19, p*243.39) controlPoint1: CGPointMake(p*272.52, p*203.65) controlPoint2: CGPointMake(p*260.68, p*226.25)];
    [bezierPath addCurveToPoint: CGPointMake(p*222.87, p*266.05) controlPoint1: CGPointMake(p*222.95, p*256.35) controlPoint2: CGPointMake(p*222.87, p*259.44)];
    [bezierPath addCurveToPoint: CGPointMake(p*246.28, p*291.29) controlPoint1: CGPointMake(p*223.48, p*270.17) controlPoint2: CGPointMake(p*234.57, p*282.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*287.02, p*368.86) controlPoint1: CGPointMake(p*275.97, p*312.73) controlPoint2: CGPointMake(p*287.02, p*333.76)];
    [bezierPath addCurveToPoint: CGPointMake(p*256.81, p*429.54) controlPoint1: CGPointMake(p*287.02, p*391.54) controlPoint2: CGPointMake(p*276.01, p*413.65)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*384, p*192)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*192)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*192)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*352, p*96)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*96)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*448, p*160)];
    [bezierPath addLineToPoint: CGPointMake(p*448, p*192)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*192)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*204.78, p*226.85)];
    [bezierPath addCurveToPoint: CGPointMake(p*214.98, p*183.14) controlPoint1: CGPointMake(p*213.42, p*217.02) controlPoint2: CGPointMake(p*217.23, p*200.68)];
    [bezierPath addCurveToPoint: CGPointMake(p*167.34, p*125.86) controlPoint1: CGPointMake(p*211, p*152.24) controlPoint2: CGPointMake(p*189.63, p*126.55)];
    [bezierPath addCurveToPoint: CGPointMake(p*166.48, p*125.85) controlPoint1: CGPointMake(p*167.05, p*125.85) controlPoint2: CGPointMake(p*166.77, p*125.85)];
    [bezierPath addCurveToPoint: CGPointMake(p*147.05, p*134.88) controlPoint1: CGPointMake(p*158.96, p*125.85) controlPoint2: CGPointMake(p*152.24, p*128.97)];
    [bezierPath addCurveToPoint: CGPointMake(p*137.18, p*177.61) controlPoint1: CGPointMake(p*138.53, p*144.57) controlPoint2: CGPointMake(p*134.93, p*160.14)];
    [bezierPath addCurveToPoint: CGPointMake(p*184.81, p*235.85) controlPoint1: CGPointMake(p*141.16, p*208.51) controlPoint2: CGPointMake(p*162.97, p*235.18)];
    [bezierPath addCurveToPoint: CGPointMake(p*204.78, p*226.85) controlPoint1: CGPointMake(p*192.49, p*236.09) controlPoint2: CGPointMake(p*199.39, p*232.97)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *PinterestPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*215.4, p*342.7)];
    [bezierPath addCurveToPoint: CGPointMake(p*138.75, p*512) controlPoint1: CGPointMake(p*202.28, p*411.52) controlPoint2: CGPointMake(p*186.25, p*477.52)];
    [bezierPath addCurveToPoint: CGPointMake(p*177.07, p*246.88) controlPoint1: CGPointMake(p*124.1, p*407.95) controlPoint2: CGPointMake(p*160.28, p*329.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*240.97, p*125.5) controlPoint1: CGPointMake(p*148.42, p*198.62) controlPoint2: CGPointMake(p*180.52, p*101.57)];
    [bezierPath addCurveToPoint: CGPointMake(p*269.73, p*323.55) controlPoint1: CGPointMake(p*315.35, p*154.93) controlPoint2: CGPointMake(p*176.57, p*304.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*346.4, p*93.58) controlPoint1: CGPointMake(p*367, p*343.1) controlPoint2: CGPointMake(p*406.7, p*154.8)];
    [bezierPath addCurveToPoint: CGPointMake(p*113.2, p*218.1) controlPoint1: CGPointMake(p*259.25, p*5.12) controlPoint2: CGPointMake(p*92.7, p*91.52)];
    [bezierPath addCurveToPoint: CGPointMake(p*125.98, p*301.15) controlPoint1: CGPointMake(p*118.17, p*249.05) controlPoint2: CGPointMake(p*150.15, p*258.45)];
    [bezierPath addCurveToPoint: CGPointMake(p*55.7, p*186.15) controlPoint1: CGPointMake(p*70.2, p*288.8) controlPoint2: CGPointMake(p*53.55, p*244.8)];
    [bezierPath addCurveToPoint: CGPointMake(p*225, p*13.68) controlPoint1: CGPointMake(p*59.15, p*90.18) controlPoint2: CGPointMake(p*141.95, p*22.98)];
    [bezierPath addCurveToPoint: CGPointMake(p*442.2, p*151.02) controlPoint1: CGPointMake(p*330.05, p*1.9) controlPoint2: CGPointMake(p*428.62, p*52.23)];
    [bezierPath addCurveToPoint: CGPointMake(p*282.48, p*374.6) controlPoint1: CGPointMake(p*457.52, p*262.52) controlPoint2: CGPointMake(p*394.82, p*383.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*215.4, p*342.7) controlPoint1: CGPointMake(p*252.05, p*372.27) controlPoint2: CGPointMake(p*239.28, p*357.2)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *PinterestRectanglePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*426.68, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.32, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.34) controlPoint1: CGPointMake(p*38.2, p*-0) controlPoint2: CGPointMake(p*0, p*38.21)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.32, p*512) controlPoint1: CGPointMake(p*0, p*473.79) controlPoint2: CGPointMake(p*38.2, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.68, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.66) controlPoint1: CGPointMake(p*473.8, p*512) controlPoint2: CGPointMake(p*512, p*473.79)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.34)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.68, p*-0) controlPoint1: CGPointMake(p*512, p*38.21) controlPoint2: CGPointMake(p*473.8, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*280.82, p*342.06)];
    [bezierPath addCurveToPoint: CGPointMake(p*229.57, p*317.66) controlPoint1: CGPointMake(p*257.56, p*340.25) controlPoint2: CGPointMake(p*247.8, p*328.73)];
    [bezierPath addCurveToPoint: CGPointMake(p*171, p*447) controlPoint1: CGPointMake(p*219.54, p*370.24) controlPoint2: CGPointMake(p*207.29, p*420.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*200.29, p*244.44) controlPoint1: CGPointMake(p*159.8, p*367.52) controlPoint2: CGPointMake(p*187.45, p*307.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*249.1, p*151.71) controlPoint1: CGPointMake(p*178.39, p*207.59) controlPoint2: CGPointMake(p*202.92, p*133.43)];
    [bezierPath addCurveToPoint: CGPointMake(p*271.06, p*303.01) controlPoint1: CGPointMake(p*305.91, p*174.18) controlPoint2: CGPointMake(p*199.9, p*288.71)];
    [bezierPath addCurveToPoint: CGPointMake(p*329.63, p*127.3) controlPoint1: CGPointMake(p*345.37, p*317.95) controlPoint2: CGPointMake(p*375.71, p*174.08)];
    [bezierPath addCurveToPoint: CGPointMake(p*151.48, p*222.48) controlPoint1: CGPointMake(p*263.05, p*59.75) controlPoint2: CGPointMake(p*135.83, p*125.76)];
    [bezierPath addCurveToPoint: CGPointMake(p*161.24, p*285.93) controlPoint1: CGPointMake(p*155.28, p*246.13) controlPoint2: CGPointMake(p*179.71, p*253.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*107.55, p*198.07) controlPoint1: CGPointMake(p*118.63, p*276.48) controlPoint2: CGPointMake(p*105.91, p*242.88)];
    [bezierPath addCurveToPoint: CGPointMake(p*236.89, p*66.29) controlPoint1: CGPointMake(p*110.19, p*124.74) controlPoint2: CGPointMake(p*173.44, p*73.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*402.85, p*171.23) controlPoint1: CGPointMake(p*317.14, p*57.31) controlPoint2: CGPointMake(p*392.45, p*95.75)];
    [bezierPath addCurveToPoint: CGPointMake(p*280.82, p*342.06) controlPoint1: CGPointMake(p*414.55, p*256.42) controlPoint2: CGPointMake(p*366.62, p*348.69)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *PinterestCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.61, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*280.82, p*342.06)];
    [bezierPath addCurveToPoint: CGPointMake(p*229.57, p*317.66) controlPoint1: CGPointMake(p*257.56, p*340.25) controlPoint2: CGPointMake(p*247.8, p*328.73)];
    [bezierPath addCurveToPoint: CGPointMake(p*171, p*447) controlPoint1: CGPointMake(p*219.54, p*370.24) controlPoint2: CGPointMake(p*207.29, p*420.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*200.28, p*244.44) controlPoint1: CGPointMake(p*159.8, p*367.51) controlPoint2: CGPointMake(p*187.45, p*307.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*249.09, p*151.7) controlPoint1: CGPointMake(p*178.39, p*207.59) controlPoint2: CGPointMake(p*202.92, p*133.42)];
    [bezierPath addCurveToPoint: CGPointMake(p*271.06, p*303.01) controlPoint1: CGPointMake(p*305.91, p*174.18) controlPoint2: CGPointMake(p*199.89, p*288.71)];
    [bezierPath addCurveToPoint: CGPointMake(p*329.63, p*127.3) controlPoint1: CGPointMake(p*345.37, p*317.95) controlPoint2: CGPointMake(p*375.7, p*174.08)];
    [bezierPath addCurveToPoint: CGPointMake(p*151.48, p*222.48) controlPoint1: CGPointMake(p*263.05, p*59.75) controlPoint2: CGPointMake(p*135.83, p*125.76)];
    [bezierPath addCurveToPoint: CGPointMake(p*161.24, p*285.93) controlPoint1: CGPointMake(p*155.28, p*246.12) controlPoint2: CGPointMake(p*179.71, p*253.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*107.55, p*198.07) controlPoint1: CGPointMake(p*118.63, p*276.48) controlPoint2: CGPointMake(p*105.91, p*242.88)];
    [bezierPath addCurveToPoint: CGPointMake(p*236.89, p*66.29) controlPoint1: CGPointMake(p*110.18, p*124.74) controlPoint2: CGPointMake(p*173.44, p*73.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*402.85, p*171.23) controlPoint1: CGPointMake(p*317.14, p*57.31) controlPoint2: CGPointMake(p*392.45, p*95.74)];
    [bezierPath addCurveToPoint: CGPointMake(p*280.82, p*342.06) controlPoint1: CGPointMake(p*414.55, p*256.42) controlPoint2: CGPointMake(p*366.62, p*348.69)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *DribblePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256.01) controlPoint1: CGPointMake(p*114.61, p*512) controlPoint2: CGPointMake(p*0, p*397.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*0, p*114.63) controlPoint2: CGPointMake(p*114.62, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256.01) controlPoint1: CGPointMake(p*397.38, p*-0) controlPoint2: CGPointMake(p*512, p*114.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*512, p*397.39) controlPoint2: CGPointMake(p*397.38, p*512)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*465.58, p*282.86)];
    [bezierPath addCurveToPoint: CGPointMake(p*331.09, p*281.93) controlPoint1: CGPointMake(p*415.34, p*276.27) controlPoint2: CGPointMake(p*370.79, p*275.79)];
    [bezierPath addCurveToPoint: CGPointMake(p*372.1, p*432.46) controlPoint1: CGPointMake(p*347.52, p*328.79) controlPoint2: CGPointMake(p*361.27, p*379.27)];
    [bezierPath addCurveToPoint: CGPointMake(p*465.58, p*282.86) controlPoint1: CGPointMake(p*422.35, p*399.32) controlPoint2: CGPointMake(p*457.64, p*345.39)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*331.78, p*453.07)];
    [bezierPath addCurveToPoint: CGPointMake(p*289.72, p*291.12) controlPoint1: CGPointMake(p*321.64, p*393.71) controlPoint2: CGPointMake(p*307.69, p*340.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*126.35, p*422.62) controlPoint1: CGPointMake(p*222.49, p*311.3) controlPoint2: CGPointMake(p*170.22, p*354.46)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*467.3) controlPoint1: CGPointMake(p*162.16, p*450.54) controlPoint2: CGPointMake(p*207.07, p*467.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*331.78, p*453.07) controlPoint1: CGPointMake(p*282.74, p*467.3) controlPoint2: CGPointMake(p*308.22, p*462.14)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*44.69, p*256.01)];
    [bezierPath addCurveToPoint: CGPointMake(p*95.23, p*392.94) controlPoint1: CGPointMake(p*44.69, p*308.28) controlPoint2: CGPointMake(p*63.78, p*356.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*275.16, p*254.31) controlPoint1: CGPointMake(p*148.87, p*314.31) controlPoint2: CGPointMake(p*209.24, p*273.36)];
    [bezierPath addCurveToPoint: CGPointMake(p*258.05, p*216.66) controlPoint1: CGPointMake(p*269.73, p*241.54) controlPoint2: CGPointMake(p*264.11, p*228.93)];
    [bezierPath addCurveToPoint: CGPointMake(p*45.12, p*247.59) controlPoint1: CGPointMake(p*199.17, p*234.4) controlPoint2: CGPointMake(p*129.45, p*243.7)];
    [bezierPath addCurveToPoint: CGPointMake(p*44.69, p*256.01) controlPoint1: CGPointMake(p*45, p*250.39) controlPoint2: CGPointMake(p*44.69, p*253.16)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*49.46, p*211.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*240.53, p*183.21) controlPoint1: CGPointMake(p*116.01, p*208.61) controlPoint2: CGPointMake(p*180.99, p*201.2)];
    [bezierPath addCurveToPoint: CGPointMake(p*160.84, p*67.52) controlPoint1: CGPointMake(p*217.86, p*142.69) controlPoint2: CGPointMake(p*191.23, p*104.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*49.46, p*211.54) controlPoint1: CGPointMake(p*104.74, p*95.89) controlPoint2: CGPointMake(p*63, p*148.41)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*255.99, p*44.7)];
    [bezierPath addCurveToPoint: CGPointMake(p*202.49, p*51.79) controlPoint1: CGPointMake(p*237.47, p*44.7) controlPoint2: CGPointMake(p*219.61, p*47.32)];
    [bezierPath addCurveToPoint: CGPointMake(p*282.22, p*168.52) controlPoint1: CGPointMake(p*231.84, p*84.12) controlPoint2: CGPointMake(p*258.57, p*123.43)];
    [bezierPath addCurveToPoint: CGPointMake(p*393.97, p*96.18) controlPoint1: CGPointMake(p*323.32, p*151.55) controlPoint2: CGPointMake(p*361.05, p*128.19)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*44.7) controlPoint1: CGPointMake(p*356.94, p*64.19) controlPoint2: CGPointMake(p*308.78, p*44.7)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*419.55, p*122.26)];
    [bezierPath addCurveToPoint: CGPointMake(p*298.97, p*202.32) controlPoint1: CGPointMake(p*385.07, p*157.21) controlPoint2: CGPointMake(p*345.7, p*183.23)];
    [bezierPath addCurveToPoint: CGPointMake(p*317.19, p*245.05) controlPoint1: CGPointMake(p*305.34, p*216.1) controlPoint2: CGPointMake(p*311.37, p*230.43)];
    [bezierPath addCurveToPoint: CGPointMake(p*466.8, p*244.67) controlPoint1: CGPointMake(p*364.63, p*237.71) controlPoint2: CGPointMake(p*414.62, p*239.33)];
    [bezierPath addCurveToPoint: CGPointMake(p*419.55, p*122.26) controlPoint1: CGPointMake(p*464.34, p*198.35) controlPoint2: CGPointMake(p*447.14, p*155.96)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *DribbleRectanglePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*152.28, p*389.3)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*425.04) controlPoint1: CGPointMake(p*180.93, p*411.63) controlPoint2: CGPointMake(p*216.86, p*425.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*316.62, p*413.66) controlPoint1: CGPointMake(p*277.39, p*425.04) controlPoint2: CGPointMake(p*297.78, p*420.91)];
    [bezierPath addCurveToPoint: CGPointMake(p*282.98, p*284.1) controlPoint1: CGPointMake(p*308.51, p*366.17) controlPoint2: CGPointMake(p*297.35, p*323.48)];
    [bezierPath addCurveToPoint: CGPointMake(p*152.28, p*389.3) controlPoint1: CGPointMake(p*229.19, p*300.24) controlPoint2: CGPointMake(p*187.38, p*334.77)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*271.33, p*254.64)];
    [bezierPath addCurveToPoint: CGPointMake(p*257.64, p*224.53) controlPoint1: CGPointMake(p*266.99, p*244.43) controlPoint2: CGPointMake(p*262.49, p*234.34)];
    [bezierPath addCurveToPoint: CGPointMake(p*87.29, p*249.27) controlPoint1: CGPointMake(p*210.54, p*238.72) controlPoint2: CGPointMake(p*154.76, p*246.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*86.95, p*256.01) controlPoint1: CGPointMake(p*87.2, p*251.52) controlPoint2: CGPointMake(p*86.95, p*253.73)];
    [bezierPath addCurveToPoint: CGPointMake(p*127.38, p*365.55) controlPoint1: CGPointMake(p*86.95, p*297.83) controlPoint2: CGPointMake(p*102.22, p*336.03)];
    [bezierPath addCurveToPoint: CGPointMake(p*271.33, p*254.64) controlPoint1: CGPointMake(p*170.29, p*302.65) controlPoint2: CGPointMake(p*218.59, p*269.89)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*366.37, p*128.14)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*86.96) controlPoint1: CGPointMake(p*336.75, p*102.55) controlPoint2: CGPointMake(p*298.23, p*86.96)];
    [bezierPath addCurveToPoint: CGPointMake(p*213.19, p*92.63) controlPoint1: CGPointMake(p*241.18, p*86.96) controlPoint2: CGPointMake(p*226.89, p*89.06)];
    [bezierPath addCurveToPoint: CGPointMake(p*276.97, p*186.02) controlPoint1: CGPointMake(p*236.67, p*118.49) controlPoint2: CGPointMake(p*258.06, p*149.94)];
    [bezierPath addCurveToPoint: CGPointMake(p*366.37, p*128.14) controlPoint1: CGPointMake(p*309.86, p*172.44) controlPoint2: CGPointMake(p*340.04, p*153.75)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*179.88, p*105.21)];
    [bezierPath addCurveToPoint: CGPointMake(p*90.77, p*220.43) controlPoint1: CGPointMake(p*135, p*127.91) controlPoint2: CGPointMake(p*101.6, p*169.93)];
    [bezierPath addCurveToPoint: CGPointMake(p*243.63, p*197.77) controlPoint1: CGPointMake(p*144.01, p*218.08) controlPoint2: CGPointMake(p*195.99, p*212.16)];
    [bezierPath addCurveToPoint: CGPointMake(p*179.88, p*105.21) controlPoint1: CGPointMake(p*225.49, p*165.35) controlPoint2: CGPointMake(p*204.19, p*134.9)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*316.07, p*276.74)];
    [bezierPath addCurveToPoint: CGPointMake(p*348.88, p*397.17) controlPoint1: CGPointMake(p*329.22, p*314.23) controlPoint2: CGPointMake(p*340.22, p*354.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*423.67, p*277.49) controlPoint1: CGPointMake(p*389.08, p*370.66) controlPoint2: CGPointMake(p*417.31, p*327.51)];
    [bezierPath addCurveToPoint: CGPointMake(p*316.07, p*276.74) controlPoint1: CGPointMake(p*383.47, p*272.22) controlPoint2: CGPointMake(p*347.83, p*271.83)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*426.67, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.35) controlPoint1: CGPointMake(p*38.41, p*-0) controlPoint2: CGPointMake(p*0, p*38.4)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*0, p*473.62) controlPoint2: CGPointMake(p*38.41, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.67, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.65) controlPoint1: CGPointMake(p*473.61, p*512) controlPoint2: CGPointMake(p*512, p*473.63)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.35)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.67, p*-0) controlPoint1: CGPointMake(p*512, p*38.4) controlPoint2: CGPointMake(p*473.61, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*460.8)];
    [bezierPath addCurveToPoint: CGPointMake(p*51.2, p*256.01) controlPoint1: CGPointMake(p*142.89, p*460.8) controlPoint2: CGPointMake(p*51.2, p*369.11)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*51.2) controlPoint1: CGPointMake(p*51.2, p*142.9) controlPoint2: CGPointMake(p*142.89, p*51.2)];
    [bezierPath addCurveToPoint: CGPointMake(p*460.8, p*256.01) controlPoint1: CGPointMake(p*369.1, p*51.2) controlPoint2: CGPointMake(p*460.8, p*142.9)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*460.8) controlPoint1: CGPointMake(p*460.8, p*369.11) controlPoint2: CGPointMake(p*369.1, p*460.8)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*290.37, p*213.06)];
    [bezierPath addCurveToPoint: CGPointMake(p*304.95, p*247.24) controlPoint1: CGPointMake(p*295.47, p*224.08) controlPoint2: CGPointMake(p*300.29, p*235.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*424.64, p*246.94) controlPoint1: CGPointMake(p*342.9, p*241.36) controlPoint2: CGPointMake(p*382.9, p*242.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*386.84, p*149.01) controlPoint1: CGPointMake(p*422.67, p*209.88) controlPoint2: CGPointMake(p*408.91, p*175.97)];
    [bezierPath addCurveToPoint: CGPointMake(p*290.37, p*213.06) controlPoint1: CGPointMake(p*359.25, p*176.97) controlPoint2: CGPointMake(p*327.76, p*197.78)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *DribbleCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*373.27, p*120.15)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*76.39) controlPoint1: CGPointMake(p*341.8, p*92.96) controlPoint2: CGPointMake(p*300.87, p*76.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*210.51, p*82.42) controlPoint1: CGPointMake(p*240.25, p*76.39) controlPoint2: CGPointMake(p*225.07, p*78.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*278.28, p*181.64) controlPoint1: CGPointMake(p*235.47, p*109.9) controlPoint2: CGPointMake(p*258.19, p*143.32)];
    [bezierPath addCurveToPoint: CGPointMake(p*373.27, p*120.15) controlPoint1: CGPointMake(p*313.22, p*167.22) controlPoint2: CGPointMake(p*345.29, p*147.36)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*175.12, p*95.79)];
    [bezierPath addCurveToPoint: CGPointMake(p*80.44, p*218.21) controlPoint1: CGPointMake(p*127.43, p*119.91) controlPoint2: CGPointMake(p*91.95, p*164.55)];
    [bezierPath addCurveToPoint: CGPointMake(p*242.85, p*194.13) controlPoint1: CGPointMake(p*137.01, p*215.72) controlPoint2: CGPointMake(p*192.24, p*209.42)];
    [bezierPath addCurveToPoint: CGPointMake(p*175.12, p*95.79) controlPoint1: CGPointMake(p*223.58, p*159.69) controlPoint2: CGPointMake(p*200.94, p*127.33)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*308.02, p*246.69)];
    [bezierPath addCurveToPoint: CGPointMake(p*435.18, p*246.37) controlPoint1: CGPointMake(p*348.34, p*240.45) controlPoint2: CGPointMake(p*390.83, p*241.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*395.02, p*142.32) controlPoint1: CGPointMake(p*433.09, p*207) controlPoint2: CGPointMake(p*418.47, p*170.96)];
    [bezierPath addCurveToPoint: CGPointMake(p*292.52, p*210.38) controlPoint1: CGPointMake(p*365.71, p*172.03) controlPoint2: CGPointMake(p*332.25, p*194.14)];
    [bezierPath addCurveToPoint: CGPointMake(p*308.02, p*246.69) controlPoint1: CGPointMake(p*297.94, p*222.08) controlPoint2: CGPointMake(p*303.06, p*234.26)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*272.29, p*254.56)];
    [bezierPath addCurveToPoint: CGPointMake(p*257.75, p*222.56) controlPoint1: CGPointMake(p*267.67, p*243.71) controlPoint2: CGPointMake(p*262.89, p*232.99)];
    [bezierPath addCurveToPoint: CGPointMake(p*76.75, p*248.85) controlPoint1: CGPointMake(p*207.7, p*237.64) controlPoint2: CGPointMake(p*148.44, p*245.54)];
    [bezierPath addCurveToPoint: CGPointMake(p*76.38, p*256.01) controlPoint1: CGPointMake(p*76.65, p*251.24) controlPoint2: CGPointMake(p*76.38, p*253.59)];
    [bezierPath addCurveToPoint: CGPointMake(p*119.34, p*372.4) controlPoint1: CGPointMake(p*76.38, p*300.44) controlPoint2: CGPointMake(p*92.61, p*341.03)];
    [bezierPath addCurveToPoint: CGPointMake(p*272.29, p*254.56) controlPoint1: CGPointMake(p*164.94, p*305.56) controlPoint2: CGPointMake(p*216.25, p*270.75)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.62, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*473.6)];
    [bezierPath addCurveToPoint: CGPointMake(p*38.4, p*256.01) controlPoint1: CGPointMake(p*135.82, p*473.6) controlPoint2: CGPointMake(p*38.4, p*376.18)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*38.4) controlPoint1: CGPointMake(p*38.4, p*135.84) controlPoint2: CGPointMake(p*135.82, p*38.4)];
    [bezierPath addCurveToPoint: CGPointMake(p*473.6, p*256.01) controlPoint1: CGPointMake(p*376.17, p*38.4) controlPoint2: CGPointMake(p*473.6, p*135.84)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*473.6) controlPoint1: CGPointMake(p*473.6, p*376.18) controlPoint2: CGPointMake(p*376.17, p*473.6)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*319.82, p*278.04)];
    [bezierPath addCurveToPoint: CGPointMake(p*354.69, p*405.99) controlPoint1: CGPointMake(p*333.79, p*317.87) controlPoint2: CGPointMake(p*345.48, p*360.78)];
    [bezierPath addCurveToPoint: CGPointMake(p*434.14, p*278.83) controlPoint1: CGPointMake(p*397.39, p*377.83) controlPoint2: CGPointMake(p*427.39, p*331.98)];
    [bezierPath addCurveToPoint: CGPointMake(p*319.82, p*278.04) controlPoint1: CGPointMake(p*391.44, p*273.23) controlPoint2: CGPointMake(p*353.57, p*272.82)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*145.79, p*397.63)];
    [bezierPath addCurveToPoint: CGPointMake(p*255.99, p*435.6) controlPoint1: CGPointMake(p*176.24, p*421.36) controlPoint2: CGPointMake(p*214.41, p*435.6)];
    [bezierPath addCurveToPoint: CGPointMake(p*320.41, p*423.51) controlPoint1: CGPointMake(p*278.73, p*435.6) controlPoint2: CGPointMake(p*300.39, p*431.22)];
    [bezierPath addCurveToPoint: CGPointMake(p*284.66, p*285.85) controlPoint1: CGPointMake(p*311.79, p*373.05) controlPoint2: CGPointMake(p*299.93, p*327.7)];
    [bezierPath addCurveToPoint: CGPointMake(p*145.79, p*397.63) controlPoint1: CGPointMake(p*227.52, p*303) controlPoint2: CGPointMake(p*183.09, p*339.69)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *FlickrPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*0, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*256)];
    [bezierPath addCurveToPoint: CGPointMake(p*112, p*368) controlPoint1: CGPointMake(p*0, p*317.86) controlPoint2: CGPointMake(p*50.14, p*368)];
    [bezierPath addCurveToPoint: CGPointMake(p*224, p*256) controlPoint1: CGPointMake(p*173.86, p*368) controlPoint2: CGPointMake(p*224, p*317.86)];
    [bezierPath addLineToPoint: CGPointMake(p*224, p*256)];
    [bezierPath addCurveToPoint: CGPointMake(p*112, p*144) controlPoint1: CGPointMake(p*224, p*194.14) controlPoint2: CGPointMake(p*173.86, p*144)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*50.14, p*144) controlPoint2: CGPointMake(p*0, p*194.14)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*288, p*256)];
    [bezierPath addLineToPoint: CGPointMake(p*288, p*256)];
    [bezierPath addCurveToPoint: CGPointMake(p*400, p*368) controlPoint1: CGPointMake(p*288, p*317.86) controlPoint2: CGPointMake(p*338.14, p*368)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*461.86, p*368) controlPoint2: CGPointMake(p*512, p*317.86)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*256)];
    [bezierPath addCurveToPoint: CGPointMake(p*400, p*144) controlPoint1: CGPointMake(p*512, p*194.14) controlPoint2: CGPointMake(p*461.86, p*144)];
    [bezierPath addCurveToPoint: CGPointMake(p*288, p*256) controlPoint1: CGPointMake(p*338.14, p*144) controlPoint2: CGPointMake(p*288, p*194.14)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *FlickrRectanglePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*426.69, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.34) controlPoint1: CGPointMake(p*38.41, p*-0) controlPoint2: CGPointMake(p*0, p*38.41)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.65)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*0, p*473.62) controlPoint2: CGPointMake(p*38.41, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.69, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.65) controlPoint1: CGPointMake(p*473.62, p*512) controlPoint2: CGPointMake(p*512, p*473.62)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.34)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.69, p*-0) controlPoint1: CGPointMake(p*512, p*38.41) controlPoint2: CGPointMake(p*473.62, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*160, p*336)];
    [bezierPath addCurveToPoint: CGPointMake(p*80, p*256) controlPoint1: CGPointMake(p*115.82, p*336) controlPoint2: CGPointMake(p*80, p*300.18)];
    [bezierPath addCurveToPoint: CGPointMake(p*160, p*176) controlPoint1: CGPointMake(p*80, p*211.82) controlPoint2: CGPointMake(p*115.82, p*176)];
    [bezierPath addCurveToPoint: CGPointMake(p*240, p*256) controlPoint1: CGPointMake(p*204.18, p*176) controlPoint2: CGPointMake(p*240, p*211.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*160, p*336) controlPoint1: CGPointMake(p*240, p*300.18) controlPoint2: CGPointMake(p*204.18, p*336)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*352, p*336)];
    [bezierPath addCurveToPoint: CGPointMake(p*272, p*256) controlPoint1: CGPointMake(p*307.82, p*336) controlPoint2: CGPointMake(p*272, p*300.18)];
    [bezierPath addCurveToPoint: CGPointMake(p*352, p*176) controlPoint1: CGPointMake(p*272, p*211.82) controlPoint2: CGPointMake(p*307.82, p*176)];
    [bezierPath addCurveToPoint: CGPointMake(p*432, p*256) controlPoint1: CGPointMake(p*396.18, p*176) controlPoint2: CGPointMake(p*432, p*211.82)];
    [bezierPath addCurveToPoint: CGPointMake(p*352, p*336) controlPoint1: CGPointMake(p*432, p*300.18) controlPoint2: CGPointMake(p*396.18, p*336)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *FlickrCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.62, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*148, p*340)];
    [bezierPath addCurveToPoint: CGPointMake(p*64, p*256) controlPoint1: CGPointMake(p*101.61, p*340) controlPoint2: CGPointMake(p*64, p*302.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*148, p*172) controlPoint1: CGPointMake(p*64, p*209.61) controlPoint2: CGPointMake(p*101.61, p*172)];
    [bezierPath addCurveToPoint: CGPointMake(p*232, p*256) controlPoint1: CGPointMake(p*194.39, p*172) controlPoint2: CGPointMake(p*232, p*209.61)];
    [bezierPath addCurveToPoint: CGPointMake(p*148, p*340) controlPoint1: CGPointMake(p*232, p*302.39) controlPoint2: CGPointMake(p*194.39, p*340)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*364, p*340)];
    [bezierPath addCurveToPoint: CGPointMake(p*280, p*256) controlPoint1: CGPointMake(p*317.61, p*340) controlPoint2: CGPointMake(p*280, p*302.39)];
    [bezierPath addCurveToPoint: CGPointMake(p*364, p*172) controlPoint1: CGPointMake(p*280, p*209.61) controlPoint2: CGPointMake(p*317.61, p*172)];
    [bezierPath addCurveToPoint: CGPointMake(p*448, p*256) controlPoint1: CGPointMake(p*410.39, p*172) controlPoint2: CGPointMake(p*448, p*209.61)];
    [bezierPath addCurveToPoint: CGPointMake(p*364, p*340) controlPoint1: CGPointMake(p*448, p*302.39) controlPoint2: CGPointMake(p*410.39, p*340)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *MailPath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*464, p*64)];
    [bezierPath addLineToPoint: CGPointMake(p*48, p*64)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*112) controlPoint1: CGPointMake(p*21.49, p*64) controlPoint2: CGPointMake(p*0, p*85.49)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*400)];
    [bezierPath addCurveToPoint: CGPointMake(p*48, p*448) controlPoint1: CGPointMake(p*0, p*426.5) controlPoint2: CGPointMake(p*21.49, p*448)];
    [bezierPath addLineToPoint: CGPointMake(p*464, p*448)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*400) controlPoint1: CGPointMake(p*490.51, p*448) controlPoint2: CGPointMake(p*512, p*426.5)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*112)];
    [bezierPath addCurveToPoint: CGPointMake(p*464, p*64) controlPoint1: CGPointMake(p*512, p*85.49) controlPoint2: CGPointMake(p*490.51, p*64)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*43.86, p*415.84)];
    [bezierPath addLineToPoint: CGPointMake(p*32.16, p*404.13)];
    [bezierPath addLineToPoint: CGPointMake(p*164.14, p*272.16)];
    [bezierPath addLineToPoint: CGPointMake(p*175.84, p*283.87)];
    [bezierPath addLineToPoint: CGPointMake(p*43.86, p*415.84)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*468.14, p*415.84)];
    [bezierPath addLineToPoint: CGPointMake(p*336.16, p*283.87)];
    [bezierPath addLineToPoint: CGPointMake(p*347.86, p*272.16)];
    [bezierPath addLineToPoint: CGPointMake(p*479.84, p*404.13)];
    [bezierPath addLineToPoint: CGPointMake(p*468.14, p*415.84)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*272, p*309.2)];
    [bezierPath addLineToPoint: CGPointMake(p*272, p*320)];
    [bezierPath addLineToPoint: CGPointMake(p*240, p*320)];
    [bezierPath addLineToPoint: CGPointMake(p*240, p*309.2)];
    [bezierPath addLineToPoint: CGPointMake(p*32.05, p*116.4)];
    [bezierPath addLineToPoint: CGPointMake(p*52.4, p*96.05)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*284.82)];
    [bezierPath addLineToPoint: CGPointMake(p*459.6, p*96.05)];
    [bezierPath addLineToPoint: CGPointMake(p*479.95, p*116.4)];
    [bezierPath addLineToPoint: CGPointMake(p*272, p*309.2)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *MailRectanglePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*426.65, p*-0)];
    [bezierPath addLineToPoint: CGPointMake(p*85.34, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*85.33) controlPoint1: CGPointMake(p*38.41, p*-0) controlPoint2: CGPointMake(p*0, p*38.39)];
    [bezierPath addLineToPoint: CGPointMake(p*0, p*426.66)];
    [bezierPath addCurveToPoint: CGPointMake(p*85.34, p*512) controlPoint1: CGPointMake(p*0, p*473.6) controlPoint2: CGPointMake(p*38.41, p*512)];
    [bezierPath addLineToPoint: CGPointMake(p*426.66, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*426.66) controlPoint1: CGPointMake(p*473.62, p*512) controlPoint2: CGPointMake(p*512, p*473.6)];
    [bezierPath addLineToPoint: CGPointMake(p*512, p*85.33)];
    [bezierPath addCurveToPoint: CGPointMake(p*426.65, p*-0) controlPoint1: CGPointMake(p*512, p*38.39) controlPoint2: CGPointMake(p*473.62, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*128, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*128)];
    [bezierPath addCurveToPoint: CGPointMake(p*397.07, p*130.83) controlPoint1: CGPointMake(p*388.57, p*128) controlPoint2: CGPointMake(p*393, p*128.98)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*295.42)];
    [bezierPath addLineToPoint: CGPointMake(p*114.93, p*130.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*128, p*128) controlPoint1: CGPointMake(p*119, p*128.98) controlPoint2: CGPointMake(p*123.43, p*128)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*96, p*352)];
    [bezierPath addLineToPoint: CGPointMake(p*96, p*160)];
    [bezierPath addCurveToPoint: CGPointMake(p*96.07, p*158) controlPoint1: CGPointMake(p*96, p*159.33) controlPoint2: CGPointMake(p*96.03, p*158.66)];
    [bezierPath addLineToPoint: CGPointMake(p*189.9, p*267.47)];
    [bezierPath addLineToPoint: CGPointMake(p*97.1, p*360.27)];
    [bezierPath addCurveToPoint: CGPointMake(p*96, p*352) controlPoint1: CGPointMake(p*96.38, p*357.6) controlPoint2: CGPointMake(p*96, p*354.83)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*384, p*384)];
    [bezierPath addLineToPoint: CGPointMake(p*128, p*384)];
    [bezierPath addCurveToPoint: CGPointMake(p*119.73, p*382.9) controlPoint1: CGPointMake(p*125.17, p*384) controlPoint2: CGPointMake(p*122.4, p*383.62)];
    [bezierPath addLineToPoint: CGPointMake(p*210.79, p*291.84)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*344.59)];
    [bezierPath addLineToPoint: CGPointMake(p*301.21, p*291.84)];
    [bezierPath addLineToPoint: CGPointMake(p*392.27, p*382.9)];
    [bezierPath addCurveToPoint: CGPointMake(p*384, p*384) controlPoint1: CGPointMake(p*389.6, p*383.62) controlPoint2: CGPointMake(p*386.83, p*384)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*416, p*352)];
    [bezierPath addCurveToPoint: CGPointMake(p*414.9, p*360.27) controlPoint1: CGPointMake(p*416, p*354.83) controlPoint2: CGPointMake(p*415.62, p*357.6)];
    [bezierPath addLineToPoint: CGPointMake(p*322.1, p*267.47)];
    [bezierPath addLineToPoint: CGPointMake(p*415.93, p*158)];
    [bezierPath addCurveToPoint: CGPointMake(p*416, p*160) controlPoint1: CGPointMake(p*415.97, p*158.66) controlPoint2: CGPointMake(p*416, p*159.33)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*352)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIBezierPath *MailCirclePath(CGRect frame) {
    float p = CGRectGetHeight(frame) / 512;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(p*256, p*-0)];
    [bezierPath addCurveToPoint: CGPointMake(p*0, p*256) controlPoint1: CGPointMake(p*114.62, p*-0) controlPoint2: CGPointMake(p*0, p*114.62)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*512) controlPoint1: CGPointMake(p*0, p*397.38) controlPoint2: CGPointMake(p*114.62, p*512)];
    [bezierPath addCurveToPoint: CGPointMake(p*512, p*256) controlPoint1: CGPointMake(p*397.38, p*512) controlPoint2: CGPointMake(p*512, p*397.38)];
    [bezierPath addCurveToPoint: CGPointMake(p*256, p*-0) controlPoint1: CGPointMake(p*512, p*114.62) controlPoint2: CGPointMake(p*397.38, p*-0)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*128, p*128)];
    [bezierPath addLineToPoint: CGPointMake(p*384, p*128)];
    [bezierPath addCurveToPoint: CGPointMake(p*397.07, p*130.83) controlPoint1: CGPointMake(p*388.57, p*128) controlPoint2: CGPointMake(p*393, p*128.98)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*295.42)];
    [bezierPath addLineToPoint: CGPointMake(p*114.93, p*130.83)];
    [bezierPath addCurveToPoint: CGPointMake(p*128, p*128) controlPoint1: CGPointMake(p*119, p*128.98) controlPoint2: CGPointMake(p*123.43, p*128)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*96, p*352)];
    [bezierPath addLineToPoint: CGPointMake(p*96, p*160)];
    [bezierPath addCurveToPoint: CGPointMake(p*96.07, p*158) controlPoint1: CGPointMake(p*96, p*159.33) controlPoint2: CGPointMake(p*96.03, p*158.66)];
    [bezierPath addLineToPoint: CGPointMake(p*189.9, p*267.47)];
    [bezierPath addLineToPoint: CGPointMake(p*97.1, p*360.27)];
    [bezierPath addCurveToPoint: CGPointMake(p*96, p*352) controlPoint1: CGPointMake(p*96.38, p*357.6) controlPoint2: CGPointMake(p*96, p*354.83)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*384, p*384)];
    [bezierPath addLineToPoint: CGPointMake(p*128, p*384)];
    [bezierPath addCurveToPoint: CGPointMake(p*119.73, p*382.9) controlPoint1: CGPointMake(p*125.17, p*384) controlPoint2: CGPointMake(p*122.4, p*383.62)];
    [bezierPath addLineToPoint: CGPointMake(p*210.79, p*291.84)];
    [bezierPath addLineToPoint: CGPointMake(p*256, p*344.59)];
    [bezierPath addLineToPoint: CGPointMake(p*301.21, p*291.84)];
    [bezierPath addLineToPoint: CGPointMake(p*392.27, p*382.9)];
    [bezierPath addCurveToPoint: CGPointMake(p*384, p*384) controlPoint1: CGPointMake(p*389.6, p*383.62) controlPoint2: CGPointMake(p*386.83, p*384)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(p*416, p*352)];
    [bezierPath addCurveToPoint: CGPointMake(p*414.9, p*360.27) controlPoint1: CGPointMake(p*416, p*354.83) controlPoint2: CGPointMake(p*415.62, p*357.6)];
    [bezierPath addLineToPoint: CGPointMake(p*322.1, p*267.47)];
    [bezierPath addLineToPoint: CGPointMake(p*415.93, p*158)];
    [bezierPath addCurveToPoint: CGPointMake(p*416, p*160) controlPoint1: CGPointMake(p*415.97, p*158.66) controlPoint2: CGPointMake(p*416, p*159.33)];
    [bezierPath addLineToPoint: CGPointMake(p*416, p*352)];
    [bezierPath closePath];
    
    return bezierPath;
}

UIImage *GRButtonBgImage(GRButtonType type, CGFloat size, UIColor *backGroundColor, GRButtonStyle style) {
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2) size = size*2;
    
    CGSize shadowSize;
    
    if (style == GRStyleIn) shadowSize = CGSizeMake(0.1, 1.1);
    else if (style == GRStyleOut) shadowSize = CGSizeMake(-0.1, -1.1);
    else shadowSize = CGSizeZero;
    
    UIGraphicsBeginImageContext(CGSizeMake(size, size));
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor whiteColor];
    CGSize shadowOffset = shadowSize;
    CGFloat shadowBlurRadius = size/512;
    UIColor* shadow2 = [UIColor blackColor];
    CGSize shadow2Offset = shadowSize;
    CGFloat shadow2BlurRadius = size/512;
    
    //// Abstracted Attributes
    CGFloat bezierStrokeWidth;
    
    if (style == GRStyleNormal) bezierStrokeWidth = 1;
    else bezierStrokeWidth = 0;
    
    UIBezierPath* bezierPath;
    CGRect frame = CGRectMake(1, 1, size-1, size-1);
    
    switch (type) {
        case GRTypeFacebook:
            bezierPath = FacebookPath(frame);
            break;
        case GRTypeFacebookRect:
            bezierPath = FacebookRectPath(frame);
            break;
        case GRTypeFacebookCircle:
            bezierPath = FacebookCirclePath(frame);
            break;
        case GRTypeTwitter:
            bezierPath = TwitterPath(frame);
            break;
        case GRTypeTwitterRect:
            bezierPath = TwitterRectPath(frame);
            break;
        case GRTypeTwitterCircle:
            bezierPath = TwitterCirclePath(frame);
            break;
        case GRTypeGooglePlus:
            bezierPath = GooglePlusPath(frame);
            break;
        case GRTypeGooglePlusRect:
            bezierPath = GooglePlusRectanglePath(frame);
            break;
        case GRTypeGooglePlusCircle:
            bezierPath = GooglePlusCirclePath(frame);
            break;
        case GRTypeMail:
            bezierPath = MailPath(frame);
            break;
        case GRTypeMailRect:
            bezierPath = MailRectanglePath(frame);
            break;
        case GRTypeMailCircle:
            bezierPath = MailCirclePath(frame);
            break;
        case GRTypePinterest:
            bezierPath = PinterestPath(frame);
            break;
        case GRTypePinterestRect:
            bezierPath = PinterestRectanglePath(frame);
            break;
        case GRTypePinterestCircle:
            bezierPath = PinterestCirclePath(frame);
            break;
        case GRTypeDribble:
            bezierPath = DribblePath(frame);
            break;
        case GRTypeDribbleRect:
            bezierPath = DribbleRectanglePath(frame);
            break;
        case GRTypeDribbleCircle:
            bezierPath = DribbleCirclePath(frame);
            break;
        case GRTypeFlickr:
            bezierPath = FlickrPath(frame);
            break;
        case GRTypeFlickrRect:
            bezierPath = FlickrRectanglePath(frame);
            break;
        case GRTypeFlickrCircle:
            bezierPath = FlickrCirclePath(frame);
            break;
            
        default:
            break;
    }
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [backGroundColor setFill];
    [bezierPath fill];
    
    ////// Bezier Inner Shadow
    CGRect bezierBorderRect = CGRectInset([bezierPath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
    bezierBorderRect = CGRectOffset(bezierBorderRect, -shadow2Offset.width, -shadow2Offset.height);
    bezierBorderRect = CGRectInset(CGRectUnion(bezierBorderRect, [bezierPath bounds]), -1, -1);
    
    UIBezierPath* bezierNegativePath = [UIBezierPath bezierPathWithRect: bezierBorderRect];
    [bezierNegativePath appendPath: bezierPath];
    bezierNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadow2Offset.width + round(bezierBorderRect.size.width);
        CGFloat yOffset = shadow2Offset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadow2BlurRadius,
                                    shadow2.CGColor);
        
        [bezierPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(bezierBorderRect.size.width), 0);
        [bezierNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [bezierNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = bezierStrokeWidth;
    [bezierPath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIButton *GRButton(GRButtonType type, int xPosition, int yPosition, CGFloat size, id target, SEL selector, UIColor *normalBgColor, GRButtonStyle normalStyle) {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xPosition, yPosition, size, size)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:GRButtonBgImage(type, size, normalBgColor, normalStyle) forState:UIControlStateNormal];
    [button setBackgroundImage:GRButtonBgImage(type, size, [UIColor blackColor], normalStyle) forState:UIControlStateHighlighted];
    [button setAdjustsImageWhenHighlighted:NO];
    
    return button;
}
