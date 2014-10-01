//
//  ConexaoCadastrarMembro.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 01/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Membro.h"

@interface ConexaoCadastrarMembro : NSObject<NSXMLParserDelegate>
-(void)cadastrarMembro:(Membro *) membro;
@end
