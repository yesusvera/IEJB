//
//  Cidade.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 01/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cidade : NSObject

@property(nonatomic, retain) NSString *id;

@property BOOL ehCapital;

@property(nonatomic, retain) NSString *nome;

@property int idEstado;

@end
