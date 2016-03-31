/***************************************************************************
 * 版权所有： 2013
 * 文件名称：
 * 内容摘要：数据的存储
 * 编辑作者：吴海德
 * 完成日期：2013年07月25日
 ***************************************************************************/
#import <Foundation/Foundation.h>
typedef enum {
    DICTIONARY  = 0,        // 字典
    ARRAY       = 1,        // 数组
}dataType;  // 取出数据的数据类型

@interface CDataBaseOperate : NSObject 

+ (CDataBaseOperate *)instance;

// 取出数据
- (id)getData:(id)key FromTable:(NSString *)tableName where:(NSString *)where dataType:(dataType)dataType;
@end

