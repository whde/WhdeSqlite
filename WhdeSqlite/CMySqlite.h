/***************************************************************************
 * 版权所有：(2013)
 * 内容摘要：部分数据方法封装
 * 编辑作者：吴海德
 * 完成日期：2013年07月30日
 ***************************************************************************/
#import <Foundation/Foundation.h>
@interface CMySqlite : NSObject
+ (CMySqlite *)instance;

/* 数据操作公用方法 */
- (BOOL)sqlWork:(NSString *)sqlString;

/* 查找数据库路径并打开数据库 */
- (BOOL)getPathAndOpen:(NSString *)dataBaseName;

/* 创建表 */
- (BOOL)createTable:(NSString *)sqlString;

/* 插入数据 */
- (BOOL)insterData:(NSString *)sqlString;

/* 删除数据 */
- (BOOL)deleteData:(NSString *)sqlString;

/* 修改数据 */
- (BOOL)updataData:(NSString *)sqlString;

/* 查找数据 */
- (id)selectData:(NSString *)sqlString;

/* 关闭数据库 */
- (void)closeDataBase;

@end
