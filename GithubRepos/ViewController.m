//
//  ViewController.m
//  GithubRepos
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

//#import "ViewController.h"
//
//
//
//@interface ViewController ()
//
//@property (weak, nonatomic) IBOutlet UITableView *myTableView;
//
//@end
//
//
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    NSURL *url = [NSURL URLWithString: @"https://api.github.com/users/pietbinon/repos"]; //1
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL: url]; //2
//    
//    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; //3
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration]; //4
//    
//    
////    The completion handler takes 3 parameters:
////data: The data returned by the server, most of the time this will be JSON or XML.
////response: Response metadata such as HTTP headers and status codes.
////error: An NSError that indicates why the request failed, or nil when the request is successful.
//
//    
//    //This is the completion handler
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest: urlRequest completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        if (error) { //7
//            
//            //Handle the error
//            NSLog (@"error: %@", error.localizedDescription);
//            return;
//        }
//        
//        NSError *jsonError = nil;
//        NSArray *repos = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &jsonError]; //8
//        
//        if (jsonError) { //9
//            
//            //Handle the error
//            NSLog (@"jsonError: %@", jsonError.localizedDescription);
//            return;
//        }
//        
//        //if we reach this point, we have successfully retrieved the JSON from the API
//        for (NSDictionary *repo in repos) { //10
//            
//            NSString *repoName = repo[@"name"];
//            NSLog (@"repo: %@", repoName);
//        }
//        
//        NSData *data = [NSData dataWithContentsOfURL: location];
//        UIImage *image = [UIImage imageWithData: data]; //7
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
//            
//            //This will run on the main queue
//            self.iPhoneImageView.image = image; //8
//
//        
//        
//        
//        
//        
//        
//        
//    }]; //5
//    
//    [dataTask resume]; //6
//    
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end

    
    
#import "ViewController.h"
#import "GitRepo.h"
                                      
                                      @interface ViewController ()
                                      @property (weak, nonatomic) IBOutlet UITableView *myTableView;
                                      @property (strong, nonatomic) NSMutableArray *objects;
                                      @end
                                      
                                      @implementation ViewController
                                      
                                      - (void)viewDidLoad {
                                          [super viewDidLoad];
                                          // Do any additional setup after loading the view, typically from a nib.
                                          
                                          NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/pietbinon/repos"]; // 1
                                          NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
                                          
                                          NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
                                          NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
                                          
                                          NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              
                                              if (error) { // 1
                                                  // Handle the error
                                                  NSLog(@"error: %@", error.localizedDescription);
                                                  return;
                                              }
                                              
                                              NSError *jsonError = nil;
                                              NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
                                              
                                              if (jsonError) { // 3
                                                  // Handle the error
                                                  NSLog(@"jsonError: %@", jsonError.localizedDescription);
                                                  return;
                                              }
                                              
                                              NSMutableArray<GitRepo*> *repoObjects = [[NSMutableArray alloc] init];
                                              
                                              // If we reach this point, we have successfully retrieved the JSON from the API
                                              for (NSDictionary *repo in repos) { // 4
                                                  
                                                  NSString *repoName = repo[@"name"];
                                                  NSLog(@"repo: %@", repoName);
                                                  
                                                  GitRepo *r = [[GitRepo alloc]
                                                                initWithName:repo[@"name"]
                                                                andURL:[NSURL URLWithString:repo[@"html_url"]]];
                                                  [repoObjects addObject:r];
                                              }
                                              self.objects = [repoObjects copy];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.myTableView reloadData];
                                              });
                                          }];
                                          
                                          
                                          [dataTask resume]; // 6
                                          
                                      }
                                      
                                      - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
                                          return 1;
                                      }
                                      
                                      
                                      - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
                                          return self.objects.count;
                                      }
                                      
                                      
                                      - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
                                          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
                                          
                                          GitRepo *object = self.objects[indexPath.row];
                                          cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object.name, object.url];
                                          return cell;
                                      }
                                      
                                      
                                      
                                      
                                      @end





//1. Create a new NSURL object from the github url string.
//2. Create a new NSURLRequest object using the URL object. Use this object to make configurations specific to the URL. For example, specifying if this is a GET or POST request, or how we should cache data.
//3. An NSURLSessionConfiguration object defines the behavior and policies to use when making a request with an NSURLSession object. We can set things like the caching policy on this object, similar to the NSURLRequest object, but we can use the session configuration to create many different requests, where any configurations we make to the NSURLRequest object will only apply to that single request. The default system values are good for now, so we'll just grab the default configuration.
//4. Create an NSURLSession object using our session configuration. Any changes we want to make to our configuration object must be done before this.
//5. We create a task that will actually get the data from the server. The session creates and configures the task and the task makes the request. Data tasks send and receive data using NSData objects. Data tasks are intended for short, often interactive requests to a server. Check out the NSURLSession API Referece for more info on this. We could optionally use a delegate to get notified when the request has completed, but we're going to use a completion block instead. This block will get called when the network request is complete, weather it was successful or not.
//6. A task is created in a suspended state, so we need to resume it. We can also You can also suspend, resume and cancel tasks whenever we want. This can be incredibly useful when downloading larger files using a download task.
//7. If there was an error, we want to handle it straight away so we can fix it. Here we're checking if there was an error, logging the description, then returning out of the block since there's no point in continuing.
//8. The data task retrieves data from the server as an NSData object because the server could return anything. We happen to know that this server is returning JSON so we need a way to convert this data to JSON. Luckily we can just use the NSJSONSerialization object to do just that. We know that the top level object in the JSON response is a JSON object (not an array or string) so we're setting the json as a dictionary.
//9. If there was an error getting JSON from the NSData, like if the server actually returned XML to us, then we want to handle it here.
//10. If we get to this point, we have the JSON data back from our request, so let's use it. When we made this request in our browser, we saw something similar to this:

