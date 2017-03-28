//
//  GitRepo.h
//  GithubRepos
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GitRepo : NSObject

@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithName:(NSString*)name andURL:(NSURL*)url;

@end
