/***************************************************************************
 * 版权所有：(2013)
 * 编辑作者：吴海德
 * 完成日期：2013年07月30日
 ***************************************************************************/
#import "CMySqlite.h"
#import <sqlite3.h>
CMySqlite *_mySqlite = nil;
@implementation CMySqlite{
    /* 数据库类 */
    sqlite3 *_dataBase;
    
    /* 查询的结果 */
    NSMutableArray *_allInfoArray;
}

- (id)init {
    if (_mySqlite != nil) {
        return nil;
    } else if ((self = [super init]) != nil) {
        _mySqlite = self;
    }
    return self;
}
+ (CMySqlite *)instance {
    if (_mySqlite == nil) {
        _mySqlite = [[CMySqlite alloc] init];
    }
    return _mySqlite;
}
-(BOOL)sqlWork:(NSString *)sqlString {
    if (sqlString.length > 0) {
        char *err;
        if (sqlite3_exec(_dataBase, [sqlString UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            sqlite3_close(_dataBase);
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)getPath:(NSString *)fileName {
    /* 文件名：YunDaApp.sqlite */
    // exestr: YUnDaApp
    NSString *exestr = [fileName stringByDeletingPathExtension];
    
    // extension: .sqlite
    NSString *extension = [fileName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:exestr ofType:extension];
    // NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/PostCode.sqlite"];
    return path;
}

- (BOOL)getPathAndOpen:(NSString *)dataBaseName {
    if (dataBaseName.length > 0) {
        // 获取数据库的路径
        NSString *database_path = [self getPath:dataBaseName];
        if (sqlite3_open([database_path UTF8String], &_dataBase) != SQLITE_OK) {
            sqlite3_close(_dataBase);
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)createTable:(NSString *)sqlString {
    if (sqlString.length > 0) {
        return [self sqlWork:sqlString];
    } else {
        return NO;
    }
}

- (BOOL)insterData:(NSString *)sqlString {
    if (sqlString.length > 0) {
        return [self sqlWork:sqlString];
    } else {
        return NO;
    }
}

- (BOOL)deleteData:(NSString *)sqlString {
    if (sqlString.length > 0) {
        return [self sqlWork:sqlString];
    } else {
        return NO;
    }
}

- (BOOL)updataData:(NSString *)sqlString {
    if (sqlString.length > 0) {
        return [self sqlWork:sqlString];
    } else {
        return NO;
    }
}

- (id)selectData:(NSString *)sqlString {
    if (sqlString.length > 0) {
        sqlite3_stmt * statement;
        if (sqlite3_prepare_v2(_dataBase, [sqlString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            _allInfoArray = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int column = sqlite3_data_count(statement);
                NSMutableDictionary *everyInfoDic = [[NSMutableDictionary alloc] init];
                // 每一个元组存储为字典
                for (int i = 1; i <= column; i++) {
                    char *valueString = (char*)sqlite3_column_text(statement, i-1);
                    
                    // 处理字典的 value=nil 的情况
                    if (valueString == nil) {
                        valueString = (char *)"";
                    }
                    NSMutableString *myValue = [NSMutableString stringWithUTF8String:valueString];
                    if (myValue == nil) {
                        myValue = [NSMutableString stringWithFormat:@""];
                    }
                    
                    // 根据对应的值找到对应的Key，放入字典中
                    [everyInfoDic setValue:myValue forKey:[NSString stringWithUTF8String:sqlite3_column_name(statement, i-1)]];
                }
                [_allInfoArray addObject:everyInfoDic];
            }
            if (_allInfoArray.count > 0) {
                return _allInfoArray;
            }
            return nil;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)closeDataBase {
    sqlite3_close(_dataBase);
}


@end
