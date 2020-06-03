//单例
#define DECLARE_SINGLETON(CLASS_NAME) \
+ (CLASS_NAME *)sharedInstance;


#define SYNTHESIZE_SINGLETONE_FOR_CLASS(CLASS_NAME) \
+ (CLASS_NAME *)sharedInstance\
{\
static CLASS_NAME *__##CLASS_NAME##_instance = nil;\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
__##CLASS_NAME##_instance = [[CLASS_NAME alloc] init];\
});\
return __##CLASS_NAME##_instance;\
}
