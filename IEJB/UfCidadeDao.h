//
//  UfCidadeDao.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 27/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UfCidadeDao : NSObject


- (NSArray *)buscarUfCidades;
- (NSArray *)buscarUfs;
- (NSArray *)buscarCidadesPor:(int) idUF;
@end
