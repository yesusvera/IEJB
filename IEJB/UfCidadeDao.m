//
//  UfCidadeDao.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 27/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "UfCidadeDao.h"
#import "SCSQLite.h"
#import "UfCidades.h"

@implementation UfCidadeDao


- (NSArray *)buscarUfCidades{
    
    NSArray *resultsUFCidades = [SCSQLite selectRowSQL: @"Select tb_uf.sigla, tb_cidade.nome from tb_uf, tb_cidade where tb_uf.id = tb_cidade.idEstado order by tb_uf.id"];
    
    int i = 0;
    NSString *uf= @"";
    NSMutableArray *listaUfCidades = [[NSMutableArray alloc]init];
    UfCidades *ufCidade = [[UfCidades alloc]init];
    NSMutableArray *cidades;
    while(i < resultsUFCidades.count){
        
        NSDictionary *resultUfCidade = [resultsUFCidades objectAtIndex:i];
        
        if (![[resultUfCidade objectForKey:@"sigla"] isEqualToString:uf]) {
            
            if (![uf isEqualToString:@""]){
                
                ufCidade.uf = uf;
                ufCidade.cidades = cidades;
                [listaUfCidades addObject:ufCidade];
                
                ufCidade = [[UfCidades alloc]init];
            }
            
            cidades = [[NSMutableArray alloc]init];
            
            uf = [resultUfCidade objectForKey:@"sigla"];
        }
        
        [cidades addObject:[resultUfCidade objectForKey:@"nome"]];
        
        i++;
    }
    
    ufCidade.uf = uf;
    ufCidade.cidades = cidades;
    [listaUfCidades addObject:ufCidade];
    
    ufCidade = nil;
    cidades = nil;
    resultsUFCidades = nil;
    
    return listaUfCidades;
}

@end
