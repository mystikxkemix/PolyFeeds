//
//  DBManager.h
//  PolyFeeds
//
//  Created by Gabin NIVERT on 20/10/2015.
//  Copyright © 2015 Gabin NIVERT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;

-(void)copyDatabaseIntoDocumentsDirectory;

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@end
