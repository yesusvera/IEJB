//
//  JYCadastroEclesiasticoViewController.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroEclesiasticoViewController.h"

@interface JYCadastroEclesiasticoViewController ()

@end

@implementation JYCadastroEclesiasticoViewController
@synthesize anoConversao, igrejaOrigem, motivoMudanca, miniterio, funcao, trabDesenvolvidos, webData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Comando para fechar os componentes na Scrool Vew. Ex: Teclado, PickerView, DatePickerView. etc...
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [barraRolagemEcles addGestureRecognizer:yourTap];
    
    //PickerView com as opções de Cidade
    opcoesMinisterios = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesMinisterios setDelegate:self];
    [opcoesMinisterios setDataSource:self];
    miniterio.inputView = opcoesMinisterios;
    NSString *plistCaminho = [[NSBundle mainBundle]
                              pathForResource:@"ministerios"  ofType:@"plist"];
    listaMinisterios = [NSArray
                        arrayWithContentsOfFile:plistCaminho];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)concluirCadastro:(id)sender {
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v1=\"http://www.iejb.com/servicos/CadastrarMembroWS/v1\">"
                             "<soapenv:Header/>"
                             "<soapenv:Body>"
                             "<v1:cadastroMembro>"
                             "<membro>"
                             "<id></id>"
                             "<nome>MARIANA</nome>"
                             "<nomeConjuge></nomeConjuge>"
                             "<cpf>23234234</cpf>"
                             "<sexo>F</sexo>"
                             "<dataNascimento></dataNascimento>"
                             "<tipoSanguineo></tipoSanguineo>"
                             "<email></email>"
                            
                            " <!--Zero or more repetitions:-->"
                            " <filhos>"
                            " <dataNascimento></dataNascimento>"
                            " <id></id>"
                            " <nome></nome>"
                             "<sexo></sexo>"
                             "</filhos>"
                             "<endereco></endereco>"
                             "<bairro></bairro>"
                             "<cidade>"
                             "<id>1</id>"
                             "</cidade>"
                             
                             "<cep></cep>"
                             
                             "<telefoneFixo></telefoneFixo>"
                             "<telefoneCelular></telefoneCelular>"
                             "<telefoneComercial></telefoneComercial>"
                             
                             "<usuario>"
                             "<login></login>"
                             "<senha></senha>"
                             "</usuario>"
                             
                             "<hashConfirmacaoCadastro></hashConfirmacaoCadastro>"
                             "<doencas></doencas>"
                             "<necessidadesEspeciais></necessidadesEspeciais>"
                             "<grauInstrucao></grauInstrucao>"
                             "<profissao></profissao>"
                             "<aptidoes></aptidoes>"
                             
                             "<eclesiastico>"
                             "<anoConversao></anoConversao>"
                             "<id></id>"
                             "<igrejaOrigem></igrejaOrigem>"
                             "<ministerio></ministerio>"
                             "<motivoMudancaIgreja></motivoMudancaIgreja>"
                             "<musico></musico>"
                             "<trabalhosExecutados></trabalhosExecutados>"
                             "</eclesiastico>"
                             
                             "<social>"
                             "<id></id>"
                             "<necessidadesImediatas></necessidadesImediatas>"
                             "<necessidadesLongoPrazo></necessidadesLongoPrazo>"
                             "<necessidadesMedioPrazo></necessidadesMedioPrazo>"
                             "<pedidosOracao></pedidosOracao>"
                             "<rendaFamiliar></rendaFamiliar>"
                             "<rendaPessoal></rendaPessoal>"
                             "<temCasaPropria></temCasaPropria>"
                             "<eEmpregado></eEmpregado>"
                             "</social>"
                             "</membro>"
                             
                             "<user>iejbUser8234</user>"
                             "<pass>iejb_298RF@@!</pass>"
                             "</v1:cadastroMembro>"
                             "</soapenv:Body>"
                             "</soapenv:Envelope>\n"];
    
    
    NSLog(@"%@", soapMessage);
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.xignite.com/xRealTime.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"http://localhost:8080/SGIJardimBotanicoWEB/CadastrarMembroWS" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    
    if(theConnection)
    {
        webData = [NSMutableData data];
        
    }
    else 
    {
        NSLog(@"theConnection is null");
    }
    

    
    
//    UIAlertView *perguntaConcluirCad = [[UIAlertView alloc]
//                                        initWithTitle:@"Cadastro de Membro"
//                                        message:@"Deseja concluir o cadastro?"
//                                        delegate:self
//                                        cancelButtonTitle:@"Cancelar"
//                                        otherButtonTitles:@"Concluir", nil];
//    
//    [perguntaConcluirCad show];
}

//Compando para controlar os componentes na ScroolView
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer {
    
    [self.view endEditing:YES];
}

#pragma mark - UIPickerView Delegate

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView == opcoesMinisterios){
        return [listaMinisterios count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView == opcoesMinisterios){
        
        return [listaMinisterios objectAtIndex:row];;
    }
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == opcoesMinisterios){
        miniterio.text = [listaMinisterios objectAtIndex:row];
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


@end
