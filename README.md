# WhdeSqlite
根据SQL语句操作数据库, 同时封装查询
```objective-c
#import <WhdeSqlite/WhdeSqlite.h>
```
- 查询
```objective-c
 // SQL-1. province like '%广东%' and city like '%深圳%' and district like '%南山%'
 NSString *where = [NSString stringWithFormat:
                   @"province like '%%%@%%' and city like '%%%@%%' and district like '%%%@%%'",
                   province, city, district];
NSDictionary *dic = [[CDataBaseOperate instance] getData:DATABASE_POSTCODE
                                               FromTable:DATABASE_TABLE
                                                   where:where
                                                dataType:DICTIONARY];
```
