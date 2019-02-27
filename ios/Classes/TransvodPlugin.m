#import "TransvodPlugin.h"

@interface TransvodPlugin()
@property (nonatomic, strong) NSObject<FlutterTextureRegistry> *textures;
@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic, weak) EAGLSharegroup *sharegroup;
@end

@implementation TransvodPlugin

- (instancetype)initWithTextures:(NSObject<FlutterTextureRegistry> *)textures {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveEAGLContextsharegroup:) name:@"EAGLContextsharegroup" object:nil];
        _textures = textures;
    }
    return self;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"gl_texture"
                                     binaryMessenger:[registrar messenger]];
    TransvodPlugin* instance = [[TransvodPlugin alloc] initWithTextures:[registrar textures]];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)saveEAGLContextsharegroup:(NSNotification *)notify{
    self.sharegroup = notify.object;
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3 sharegroup:self.sharegroup];
    if(!self.context){
        self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:self.sharegroup];
    }
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"create" isEqualToString:call.method]) {
        CGFloat width = [call.arguments[@"width"] floatValue];
        CGFloat height = [call.arguments[@"height"] floatValue];
        
        NSInteger textureId;
        
        result(@(textureId));
    } else if ([@"dispose" isEqualToString:call.method]) {
        NSNumber *textureId = call.arguments[@"textureId"];

        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
