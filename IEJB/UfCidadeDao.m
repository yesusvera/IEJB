//
//  UfCidadeDao.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 27/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "UfCidadeDao.h"
#import "SCSQLite.h"

@implementation UfCidadeDao


- (NSArray *)buscarUfCidades{
    
    NSArray *resultsUFCidades = [SCSQLite selectRowSQL: @"select u.sigla, c.nome from tb_uf u, tb_cidade c where u.id = c.idEstado order by u.id"];
    
    int i = 0;
    NSString *uf;
    NSArray *listaUfCidades = [[NSArray alloc]init];
    NSDictionary *ufCidade = [[NSDictionary alloc]init];
    NSArray *cidades;
    while(i < resultsUFCidades.count){
        
        NSDictionary *resultUfCidade = [resultsUFCidades objectAtIndex:i];
        
        
        if (![[resultUfCidade objectForKey:@"sigla"] isEqualToString:uf]) {
            
            [ufCidade setValue:[resultUfCidade objectForKey:@"sigla"] forKey:@"uf"];
            cidades = [[NSArray alloc]init];
            
            uf = [resultUfCidade objectForKey:@"sigla"];
        }
        
        [cidades setValue:[resultUfCidade objectForKey:@"cidade"] forKey:uf];
        
        i++;
        
    }
    
    return listaUfCidades;
    
}

@end
