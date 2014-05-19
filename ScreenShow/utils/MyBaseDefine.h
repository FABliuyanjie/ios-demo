
#ifndef MYBASEDEFINE_H
#define MYBASEDEFINE_H


///////////////////////////////////////////////////////////////////////////////////////////////////
// Safe releases

#define MY_OBJ_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define MY_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }

#define TT_FIX_CATEGORY_BUG(name) NS_ROOT_CLASS @interface TT_FIX_CATEGORY_BUG_##name @end \
@implementation TT_FIX_CATEGORY_BUG_##name @end


#define IS_MASK_SET(value, flag)  (((value) & (flag)) == (flag))


///////////////////////////////////////////////////////////////////////////////////////////////////
// Time

#define T_MINUTE 60
#define T_HOUR   (60 * T_MINUTE)
#define T_DAY    (24 * T_HOUR)
#define T_5_DAYS (5 * T_DAY)
#define T_WEEK   (7 * T_DAY)
#define T_MONTH  (30.5 * T_DAY)
#define T_YEAR   (365 * T_DAY)


//

#define INT_TO_OBJ(i)       [NSNumber numberWithInt:i]
#define BOOL_TO_OBJ(b)      [NSNumber numberWithBool:b]
#define FLOAT_TO_OBJ(f)     [NSNumber numberWithFloat:f]
#define DOUBLE_TO_OBJ(d)    [NSNumber numberWithDouble:d]
#define LONG_TO_OBJ(l)      [NSNumber numberWithLong:l]
#define LONGLONG_TO_OBJ(ll) [NSNumber numberWithLongLong:ll]

#define INT_TO_STRING(i)		[NSString stringWithFormat:@"%d",i]
#define LONGLONG_TO_STRING(ll)	[NSString stringWithFormat:@"%lld",ll]
#define MONEY_TO_STRING(i)	[NSString stringWithFormat:@"￥%.2f",i]

#define DATA_TO_OBJ(data)   [NSKeyedUnarchiver unarchiveObjectWithData:data]
#define OBJ_TO_DATA(obj)    [NSKeyedArchiver archivedDataWithRootObject:obj]


#define SYSTEMVERSION_GREATER_THAN(v) ([[UIDevice currentDevice].systemVersion floatValue] >= v)


#endif