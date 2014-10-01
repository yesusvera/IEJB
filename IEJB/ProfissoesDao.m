//
//  ProfissoesDao.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 30/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "ProfissoesDao.h"
#import "SCSQLite.h"

@implementation ProfissoesDao

- (NSArray *)buscarProfissoes{
    
    NSArray *resultProfissoes = [SCSQLite selectRowSQL: @"Select nome_prof from tb_profissoes order by id_prof"];
    
    int i = 0;
    NSMutableArray *listaProfissoes = [[NSMutableArray alloc] init];
    while(i < resultProfissoes.count){
        
        NSDictionary *profissoes = [resultProfissoes objectAtIndex:i];
        
        [listaProfissoes addObject:[profissoes objectForKey:@"nome_prof"]];
        
        i++;
    }

    return listaProfissoes;
}

@end
