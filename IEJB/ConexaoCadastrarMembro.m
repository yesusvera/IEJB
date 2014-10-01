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

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"response"]){
       // registrarLivroResponse = [[RegistrarLivroResponse alloc] init];
    }
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
    
    if([elementName isEqualToString:@"response"] || [elementName isEqualToString:@"livro"]){
        return;
    } else if([elementName isEqualToString:@"codigolivro"]){
      //  [registrarLivroResponse setCodLivro:valorElementoAtual];
    }else if([elementName isEqualToString:@"status"]){
       // [registrarLivroResponse setStatus:valorElementoAtual];
    }else if([elementName isEqualToString:@"erro"]){
      //  [registrarLivroResponse setErro:valorElementoAtual];
    }else if([elementName isEqualToString:@"msgErro"]){
      //  [registrarLivroResponse setMsgErro:valorElementoAtual];
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
        
        
//        NSString *mensagemAlerta = registrarLivroResponse.status;
//        if(![registrarLivroResponse.erro isEqualToString:@"0"]){
//            mensagemAlerta = [mensagemAlerta stringByAppendingString:@" - "];
//            mensagemAlerta = [mensagemAlerta stringByAppendingString:registrarLivroResponse.msgErro];
//            
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s: AFHTTPRequestOperation error: %@", __FUNCTION__, error);
        
        UIAlertView *alertError = [
                                   [UIAlertView alloc] initWithTitle:@"Erro ao registrar livro no portal."
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
    
    NSString *urlCadMembro = @"http://localhost:8080/sgi/RCadMem?usuario=iejb2014&senha=iejb%25membro%252014&cpf=72345098104&nome=YESUS+ALFONSINO+CASTILLO+VERA&datanascimento=25121984";
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"usuario="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.usuario]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&senha="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.senha]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&cpf="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.CPF]];
    
    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&nome="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.nome]];

    urlCadMembro = [[urlCadMembro stringByAppendingString:@"&datanascimento="] stringByAppendingString: [GLB urlEncodeUsingEncoding:membro.dataNascimento]];
  
    return urlCadMembro;
}
@end
