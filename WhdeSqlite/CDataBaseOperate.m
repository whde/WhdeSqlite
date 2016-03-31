/***************************************************************************
 * 版权所有：(2013)
 * 内容摘要：数据库操作
 * 编辑作者：吴海德
 * 完成日期：2013年07月04日
 ***************************************************************************/
#import "CDataBaseOperate.h"
#import "CMySqlite.h"
#import "CSqliteField.h"
CDataBaseOperate *g_dataBaseOperate = nil;
@interface CDataBaseOperate () {
    id m_data;  // 从数据库取出的数据
}
@end

@implementation CDataBaseOperate
- (id)init {
    if (g_dataBaseOperate != nil) {
        return nil;
    }
    if ((self = [super init]) != nil) {
        g_dataBaseOperate = self;
        // [self createDB];
        
        [[CMySqlite instance] getPathAndOpen:DATABASE_NAME];
        // [self createTable];
    }
    return self;
}

+ (CDataBaseOperate *)instance {
    if (g_dataBaseOperate == nil) {
        g_dataBaseOperate = [[CDataBaseOperate alloc] init];
    }
    return g_dataBaseOperate;
}

//- (void)createDB {
// [[CMySqlite instance] getPathAndOpen:@"PostCode.sqlite"];
//}

//- (void)createTable {
//    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS code ( id TEXT, province TEXT, city TEXT, district TEXT, cityId TEXT, postcode TEXT),PRIMARY KEY(id);" ];
//    if ([[CMySqlite instance] createTable:sqlCreateTable]) {
//        CLog(@"DB_YES!!!!!!");
//    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"邮编" ofType:@"txt"];
//    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    if ([[CMySqlite instance] insterData:text]){
//        CLog(@"INSERT_YES!!!!");
//    };
//}

- (id)getData:(id)key FromTable:(NSString *)tableName where:(NSString *)where dataType:(dataType)dataType {
    // 需要取出的字段的->拼接
    NSString *selectItem = nil; 
    
    // 从数组中拼接
    if ([key isKindOfClass:[NSMutableArray class]] || [key isKindOfClass:[NSArray class]]) {
        NSMutableString *items = [NSMutableString stringWithFormat:@""];
        for (int i = 0; i < [key count]; i++) {
            [items appendFormat:@"%@,", [key objectAtIndex:i]];
        }
        
        // 去掉最后的 ','
        selectItem = [items substringToIndex:items.length - 1];
    } else {
        selectItem = (NSString *)key;
    }
    
    // 取所有字段
    if (selectItem == nil) {
        selectItem = @"*";
    }
    
    /* 打开数据库 */
    [[CMySqlite instance] getPathAndOpen:DATABASE_NAME];
    
    // SQL 语句的拼接
    NSString *select = nil;
    if (where == nil) {
        /* 查询数据：select * from table */
        select = [NSString stringWithFormat:@"SELECT %@ FROM %@", selectItem, tableName];
    } else {
        /* 查询数据 select * from table where item=value */
        select = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", selectItem, tableName, where];
    }
    
    // 取数据
    m_data = [[CMySqlite instance] selectData:select];
    
    // 返回字典
    if((dataType == DICTIONARY) && (((NSArray *)m_data).count > 0)) {
        return [m_data objectAtIndex:0];
    }
    
    // 关闭数据库
    [[CMySqlite instance] closeDataBase];
    
    return m_data;
}

@end
