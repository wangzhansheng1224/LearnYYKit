//
//  ViewController.m
//  LearnYYKit
//
//  Created by 王战胜 on 2017/10/16.
//  Copyright © 2017年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"

@interface YYBook : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) uint64_t pages;
@property (nonatomic, strong) NSDate *publishDate;
@end

@implementation YYBook
@end

static void SimpleObjectExample () {
    YYBook *book = [YYBook modelWithJSON:@"         \
                    {                                               \
                    \"rid\": 123456789,                         \
                    \"name\": \"YYKit\",                        \
                    \"createTime\" : \"2011-06-09T06:24:26Z\",  \
                    \"owner\": {                                \
                    \"uid\" : 989898,                       \
                    \"name\" : \"ibireme\"                  \
                    } \
                    }"];
    NSString *bookJSON = [book modelToJSONString];
    NSLog(@"Book: %@",bookJSON);
}


@interface YYUser : NSObject
@property (nonatomic, assign) uint64_t uid;
@property (nonatomic, copy) NSString *name;
@end

@implementation YYUser
@end

@interface YYRepo : NSObject
@property (nonatomic, assign) uint64_t rid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) YYUser *owner;
@end

@implementation YYRepo
@end

static void NestObjectExample() {
    YYRepo *repo = [YYRepo modelWithJSON:@"         \
                    {                                               \
                    \"rid\": 123456789,                         \
                    \"name\": \"YYKit\",                        \
                    \"createTime\" : \"2011-06-09T06:24:26Z\",  \
                    \"owner\": {                                \
                    \"uid\" : 989898,                       \
                    \"name\" : \"ibireme\"                  \
                    } \
                    }"];
    NSString *repoJSON = [repo modelToJSONString];
    NSLog(@"Repo: %@",repoJSON);
}


@interface YYPhoto : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;
@end

@implementation YYPhoto
@end

@interface YYAlbum : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSDictionary *likedUsers;
@property (nonatomic, strong) NSSet *likedUserIds;
@end

@implementation YYAlbum
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"photos" : YYPhoto.class,
             @"likedUsers" : YYUser.class,
             @"likedUserIds" : NSNumber.class};
}
@end

static void ContainerObjectExample() {
    YYAlbum *album = [YYAlbum modelWithJSON:@"          \
                      {                                                   \
                      \"name\" : \"Happy Birthday\",                      \
                      \"photos\" : [                                      \
                      {                                               \
                      \"url\":\"http://example.com/1.png\",       \
                      \"desc\":\"Happy~\"                         \
                      },                                              \
                      {                                               \
                      \"url\":\"http://example.com/2.png\",       \
                      \"desc\":\"Yeah!\"                          \
                      }                                               \
                      ],                                                  \
                      \"likedUsers\" : {                                  \
                      \"Jony\" : {\"uid\":10001,\"name\":\"Jony\"},   \
                      \"Anna\" : {\"uid\":10002,\"name\":\"Anna\"}    \
                      },                                                  \
                      \"likedUserIds\" : [10001,10002]                    \
                      }"];
    NSString *albumJSON = [album modelToJSONString];
    NSLog(@"Album: %@",albumJSON);
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SimpleObjectExample();
    NestObjectExample();
    ContainerObjectExample();
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
