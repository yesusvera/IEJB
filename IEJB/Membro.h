//
//  Membro.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 01/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Membro : NSObject

@property(nonatomic, retain) NSString *nome;
@property(nonatomic, retain) NSString *CPF;
@property(nonatomic, retain) NSString *dataNascimento;
@property(nonatomic, retain) NSString *tipoSanguineo;
@property(nonatomic, retain) NSString *sexo;
@property(nonatomic, retain) NSString *conjuge;
@property(nonatomic, retain) NSString *qtdFilhos;
@property(nonatomic, retain) NSString *ruaLogradouro;
@property(nonatomic, retain) NSString *bairro;
@property(nonatomic, retain) NSString *UF;
@property(nonatomic, retain) NSString *cidade;
@property(nonatomic, retain) NSString *cep;
@property(nonatomic, retain) NSString *telFixo;
@property(nonatomic, retain) NSString *telCelular;
@property(nonatomic, retain) NSString *telComercial;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSString *usuario;
@property(nonatomic, retain) NSString *senha;
@property(nonatomic, retain) NSString *confirmaSenha;

@end
