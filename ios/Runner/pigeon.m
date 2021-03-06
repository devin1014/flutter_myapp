// Autogenerated from Pigeon (v1.0.10), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}

@interface Book ()
+ (Book *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation Book
+ (Book *)fromMap:(NSDictionary *)dict {
  Book *result = [[Book alloc] init];
  result.title = dict[@"title"];
  if ((NSNull *)result.title == [NSNull null]) {
    result.title = nil;
  }
  result.author = dict[@"author"];
  if ((NSNull *)result.author == [NSNull null]) {
    result.author = nil;
  }
  return result;
}
- (NSDictionary *)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.title ? self.title : [NSNull null]), @"title", (self.author ? self.author : [NSNull null]), @"author", nil];
}
@end

@interface BookApiCodecReader : FlutterStandardReader
@end
@implementation BookApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [Book fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface BookApiCodecWriter : FlutterStandardWriter
@end
@implementation BookApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[Book class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface BookApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BookApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BookApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BookApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BookApiGetCodec() {
  static dispatch_once_t s_pred = 0;
  static FlutterStandardMessageCodec *s_sharedObject = nil;
  dispatch_once(&s_pred, ^{
    BookApiCodecReaderWriter *readerWriter = [[BookApiCodecReaderWriter alloc] init];
    s_sharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return s_sharedObject;
}


void BookApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BookApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.BookApi.search"
        binaryMessenger:binaryMessenger
        codec:BookApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(searchKey:error:)], @"BookApi api (%@) doesn't respond to @selector(searchKey:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_key = args[0];
        FlutterError *error;
        NSArray<Book *> *output = [api searchKey:arg_key error:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
