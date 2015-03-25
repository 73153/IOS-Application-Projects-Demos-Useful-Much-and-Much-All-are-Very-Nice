//
//  AMGProgressView.h
//  AMGProgressView
//
//  Created by Albert Mata on December 15th, 2012.
//  Copyright (c) Albert Mata. All rights reserved. FreeBSD License.
//  Please send comments/corrections to hello@albertmata.net or @almata on Twitter.
//  Download latest version from https://github.com/almata/AMGProgressView
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
//

#import <UIKit/UIKit.h>

@interface AMGProgressView : UIView

@property (nonatomic) BOOL  verticalGradient;          // default: NO
@property (nonatomic) float minimumValue;              // default: 0.0f
@property (nonatomic) float maximumValue;              // default: 1.0f
@property (nonatomic) float progress;                  // default: 0.0f
@property (nonatomic) float emptyPartAlpha;            // default: 0.8f
@property (nonatomic, strong) UIColor *outsideBorder;  // default: nil (no border)
@property (nonatomic, strong) NSArray *gradientColors; // default: black to white

@end