//
//  JYCadastroSocialViewController.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroSocialViewController.h"
#import "ProfissoesDao.h"

@interface JYCadastroSocialViewController ()

@end

@implementation JYCadastroSocialViewController
@synthesize profissao, grauIntrucao, renda, temCasaPropria, necessidadeCurtoPrazo, necessidadeMedioPrazo, necessidadeLongoPrazo;
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
    [barraRolagemSocial addGestureRecognizer:yourTap];
    
    //PickerView com as opções de Renda
    opcoesRendas = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesRendas setDelegate:self];
    [opcoesRendas setDataSource:self];
    renda.inputView = opcoesRendas;
    NSString *plistRendas = [[NSBundle mainBundle]
                              pathForResource:@"rendas"  ofType:@"plist"];
    listaRendas = [NSArray
                        arrayWithContentsOfFile:plistRendas];
    
    //PickerView com as opções de grau de instrução
    opcoesGrauInstrucao = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesGrauInstrucao setDelegate:self];
    [opcoesGrauInstrucao setDataSource:self];
    grauIntrucao.inputView = opcoesGrauInstrucao;
    NSString *plistGrauInstrucao = [[NSBundle mainBundle]
                              pathForResource:@"grauInstrucao"  ofType:@"plist"];
    listaGrauInstrucao = [NSArray
                   arrayWithContentsOfFile:plistGrauInstrucao];
    
    
    //PickerView com as opções de UF
    ProfissoesDao *profissoes = [[ProfissoesDao alloc]init];
    listaProfissoes = profissoes.buscarProfissoes;
    opcoesProfissoes = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesProfissoes setDelegate:self];
    [opcoesProfissoes setDataSource:self];
    profissao.inputView = opcoesProfissoes;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)concluirCadastro:(id)sender {
    
    UIAlertView *perguntaConcluirCad = [[UIAlertView alloc]
                                        initWithTitle:@"Cadastro de Membro"
                                        message:@"Deseja concluir o cadastro?"
                                        delegate:self
                                        cancelButtonTitle:@"Cancelar"
                                        otherButtonTitles:@"Concluir", nil];
    
    [perguntaConcluirCad show];
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
    
    if(pickerView == opcoesRendas){
        return [listaRendas count];
    }else if(pickerView == opcoesGrauInstrucao){
        return [listaGrauInstrucao count];
    }
    else if(pickerView == opcoesProfissoes){
        return [listaProfissoes count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView == opcoesRendas){
        
        return [listaRendas objectAtIndex:row];
        
    }else if(pickerView == opcoesGrauInstrucao){
        
        return [listaGrauInstrucao objectAtIndex:row];
    }else if(pickerView == opcoesProfissoes){
        
        return [listaProfissoes objectAtIndex:row];
    }
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == opcoesRendas){
        renda.text = [listaRendas objectAtIndex:row];
    }else if(pickerView == opcoesGrauInstrucao){
        grauIntrucao.text = [listaGrauInstrucao objectAtIndex:row];
    }else if(pickerView == opcoesProfissoes){
        profissao.text = [listaProfissoes objectAtIndex:row];
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
