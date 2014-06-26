//
//  LoginDAO.m
//  IEJB
//
//  Created by Yesus Castillo Vera on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "LoginDAO.h"
#import "SCSQLite.h"

@implementation LoginDAO

- (BOOL)loginValido:(NSString *)usuario senha:(NSString *)senha{
    NSArray *results = [SCSQLite selectRowSQL:@"Select * from tbl_login where usuario = '%@' and senha = '%@'", usuario, senha];
    return results.count > 0;
}

@end
