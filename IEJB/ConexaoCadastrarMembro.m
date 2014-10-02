//
//  ConexaoCadastrarMembro.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 01/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "ConexaoCadastrarMembro.h"
#import "GLB.h"
#import "Membro.h"
#import "AFHTTPRequestOperationManager.h"

@implementation ConexaoCadastrarMembro

NSMutableString *valorElementoAtual;
BOOL cadErro;
NSString *msgCad;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!valorElementoAtual)
    {
        valorElementoAtual = [[NSMutableString alloc]initWithString:string];
    }
    else
    {
        [valorElementoAtual appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"iejbCadMemb"]){
        return;
    }
    if([elementName isEqualToString:@"erro"]){
        if([valorElementoAtual isEqualToString:@"false"]){
            cadErro = NO;
        }else{
            cadErro = YES;
        }
    }else if([elementName isEqualToString:@"mensagem"]){
        msgCad = valorElementoAtual;
    }
    
    valorElementoAtual = nil;
    
}

-(void)cadastrarMembro:(Membro *) membro{
    NSOperationQueue *networkQueue = [[NSOperationQueue alloc] init];
    networkQueue.maxConcurrentOperationCount = 5;
    
    NSURL *url = [NSURL URLWithString:[self montarUrlParaCadastroMembro:membro]];
    NSLog(@"%@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSLog(@"%@", operation);
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *respostaXML = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", respostaXML);
        
        NSData *respDataXML = [respostaXML dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@", respostaXML);
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:respDataXML];
        [parser setDelegate:self];
        
        if(![parser parse]){
            NSLog(@"Erro ao realizar o parse");
        }else{
            NSLog(@"Ok Parse");
        }
        
        
        UIAlertView *perguntaConcluirCad = [[UIAlertView alloc]
                                                initWithTitle:@"Cadastro de Membro"
                                                message:msgCad
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
            
        [perguntaConcluirCad show];
            

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
        
        UIAlertView *alertError = [
                                   [UIAlertView alloc] initWithTitle:@"Erro cadatrar o membr!"
                                   message:error.description
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil
                                   ];
        
        [alertError show];
        
        
    }];
    
    [networkQueue addOperation:operation];
}

- (NSString *)montarUrlParaCadastroMembro:(Membro *) membro{
    
    NSString *urlCadMembro = @"http://localhost:8080/sgi/RCadMem?";
    
//    urlCadMembro = [[urlCadMembro stringByAppendingString:@"usrCadServ="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.usuario]];
//    
//    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&passCadServ="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.senha]];
    
    urlCadMembro = [urlCadMembro stringByAppendingString:@"usrCadServ=iejb2014"];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&passCadServ="] stringByAppendingString: [GLB urlEncodeUsingEncoding:@"iejb%membro%2014"]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&cpf="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.CPF]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&nome="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.nome]];

    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&nomeConjuge="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.conjuge]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&dataNascimento="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.dataNascimento]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&tipoSanguineo="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.tipoSanguineo]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&email="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.email]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&filhos="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.qtdFilhos]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&endereco="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.ruaLogradouro]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&bairro="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.bairro]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&idCidade="] stringByAppendingString: [GLB urlEncodeUsingEncoding: membro.idCidade ]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&cep="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.cep]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&telefoneFixo="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.telFixo]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&telefoneCelular="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.telCelular]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&telefoneComercial="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.telCelular]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&login="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.usuario]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&senha="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.senha]];
  
    return urlCadMembro;
}

@end
