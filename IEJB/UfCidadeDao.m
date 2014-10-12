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
#import "Cidade.h"

@implementation UfCidadeDao


- (NSArray *)buscarUfCidades{
    
    NSArray *resultsUFCidades = [SCSQLite selectRowSQL: @"Select tb_uf.sigla, tb_cidade.nome, tb_cidade.id, tb_cidade.idEstado, tb_cidade.capital from tb_uf, tb_cidade where tb_uf.id = tb_cidade.idEstado order by tb_uf.id"];
    
    int i = 0;
    NSString *uf= @"";
    NSMutableArray *listaUfCidades = [[NSMutableArray alloc]init];
    UfCidades *ufCidade = [[UfCidades alloc]init];
    NSMutableArray *cidades;
    Cidade *cidade;
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
        
        cidade = [[Cidade alloc]init];
        cidade.id = [[resultUfCidade objectForKey:@"id"] stringValue];
        //cidade.ehCapital = [[[resultUfCidade objectForKey:@"capital"] isEqualToString:@"0" ]? NO : YES];
        cidade.nome  = [resultUfCidade objectForKey:@"nome"];
        
        [cidades addObject:cidade];
        
        i++;
    }
    
    ufCidade.uf = uf;
    ufCidade.cidades = cidades;
    [listaUfCidades addObject:ufCidade];
    
    ufCidade = nil;
    cidades = nil;
    resultsUFCidades = nil;
    cidade = nil;
    
    return listaUfCidades;
}

- (NSArray *)buscarUfs{
    
    NSArray *resultsUFCidades = [SCSQLite selectRowSQL: @"Select tb_uf.sigla from tb_uf"];
    
    int i = 0;

    NSMutableArray *listaUf= [[NSMutableArray alloc]init];

    while(i < resultsUFCidades.count){
        
        NSDictionary *resultUfCidade = [resultsUFCidades objectAtIndex:i];
        
            
        [listaUf addObject:[resultUfCidade objectForKey:@"sigla"]];
        
        i++;
    }

    return listaUf;
}

- (NSArray *)buscarCidadesPor:(int) idUF {
    
    NSArray *resultsUFCidades = [SCSQLite selectRowSQL: @"Select nome from tb_cidade where idEstado = '%i'", idUF];
    
    int i = 0;
    
    NSMutableArray *listaCidadesDaUf= [[NSMutableArray alloc]init];
    
    while(i < resultsUFCidades.count){
        
        NSDictionary *resultUfCidade = [resultsUFCidades objectAtIndex:i];
        
        
        [listaCidadesDaUf addObject:[resultUfCidade objectForKey:@"nome"]];
        
        i++;
    }
    
    return listaCidadesDaUf;
}


@end
