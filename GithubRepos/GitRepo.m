//
//  GitRepo.m
//  GithubRepos
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import "GitRepo.h"

@implementation GitRepo
- (instancetype)initWithName:(NSString*)name andURL:(NSURL*)url{
    
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

@end
