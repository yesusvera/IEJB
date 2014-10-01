//
//  JYCadastroViewController.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroViewController.h"
#import "UfCidadeDao.h"
#import "UfCidades.h"
#import "Membro.h"
#import "ConexaoCadastrarMembro.h"
@interface JYCadastroViewController ()

@end

@implementation JYCadastroViewController
@synthesize nome, CPF, dataNascimento, tipoSanguineo, sexo, conjuge, qtdFilhos, ruaLogradouro, bairro, UF, cidade, cep, telFixo, telCelular, telComercial, email, usuario, senha, confirmaSenha;

BOOL concluiCad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Mostrando a barra de navegação
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //Comando para fechar os componentes na Scrool Vew. Ex: Teclado, PickerView, DatePickerView. etc...
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [barraRolagem addGestureRecognizer:yourTap];
    [barraRolagem setScrollEnabled:YES];
    [barraRolagem setContentSize:CGSizeMake(320, 1400)];
    
    //DataPickerView da data de nascimento
    listaData = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 230, 0)];
    listaData.datePickerMode = UIDatePickerModeDate;
    [listaData addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];
    [listaData removeFromSuperview];
    dataNascimento.inputView = listaData;
    
    
    //PickerView com as opções de tipo sanquineo
    listaTpSanguineo = [[NSArray alloc] initWithObjects:@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+", nil];
    opcoesTpSang = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesTpSang setDelegate:self];
    [opcoesTpSang setDataSource:self];
    tipoSanguineo.inputView = opcoesTpSang;
    
    //Setando o campo qtdFilhos com o valor padrão zero
    qtdFilhos.text = @"0";
    
    //PickerView com as opções de UF
    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
    listaUfCidade = ufCidadeDao.buscarUfCidades;
    opcoesUF = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesUF setDelegate:self];
    [opcoesUF setDataSource:self];
    UF.inputView = opcoesUF;
    
    //PickerView com as opções de Cidade
    opcoesCidade = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesCidade setDelegate:self];
    [opcoesCidade setDataSource:self];
    cidade.inputView = opcoesCidade;
    

}


// Método executado quando muda o valor do picker
- (void)getDate:(UIDatePicker *)sender {
    
    // Pegar a data do picker
    NSDate *currentDate = sender.date;
    
    // Formatar a data
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    // Exibir a data no campo de texto
    dataNascimento.text =[formatter stringFromDate:currentDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//Compando para controlar os componentes na ScroolView
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer {
    
    [self.view endEditing:YES];
}

// Confirma com o usuário se quer realmente concluir o cadastro.
- (IBAction)concluirCadastro:(id)sender {
    
    UIAlertView *perguntaConcluirCad = [[UIAlertView alloc]
                                        initWithTitle:@"Cadastro de Membro"
                                        message:@"Deseja concluir o cadastro?"
                                        delegate:self
                                        cancelButtonTitle:@"Cancelar"
                                        otherButtonTitles:@"Concluir", nil];
                                        
    [perguntaConcluirCad show];
    
    if (concluiCad) {
        Membro *membro = [[Membro alloc]init];
        
        membro.nome = nome.text;
        membro.CPF = CPF.text;
        membro.dataNascimento = dataNascimento.text;
        membro.tipoSanguineo = tipoSanguineo.text;
        membro.sexo          = sexo.textInputContextIdentifier;
        membro.conjuge     = conjuge.text;
        membro.qtdFilhos = qtdFilhos.text;
        membro.ruaLogradouro = ruaLogradouro.text;
        membro.bairro   = bairro.text;
        membro.UF = UF.text;
        membro.cidade = cidade.text;
        membro.cep = cep.text;
        membro.telFixo = telFixo.text;
        membro.telCelular = telCelular.text;
        membro.telComercial = telComercial.text;
        membro.email = email.text;
        membro.usuario = usuario.text;
        membro.senha = senha.text;
        membro.confirmaSenha = confirmaSenha.text;
        
        
        ConexaoCadastrarMembro *cadMembro = [[ConexaoCadastrarMembro alloc]init];
        
        [cadMembro cadastrarMembro:membro];
    }
}


// Metodo do para incrementar a quantidade de filhos
- (IBAction)incrementarFilhos:(id)sender {
    
    UIStepper *incrementador = (UIStepper *)sender;
    qtdFilhos.text = [NSString stringWithFormat:@"%d",
                                 (int)incrementador.value];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            break;
        case 2:
            concluiCad = YES;
            break;
            
        default:
            break;
    }
}


#pragma mark - UIPickerView Delegate

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView == opcoesTpSang) {
        return [listaTpSanguineo count];
    }else if(pickerView == opcoesUF){
        return [listaUfCidade count];
    }else if(pickerView == opcoesCidade){
        return [listaCidades count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == opcoesTpSang) {
        return [listaTpSanguineo objectAtIndex:row];
    }else if(pickerView == opcoesUF){
        UfCidades *uf =  [listaUfCidade objectAtIndex:row];
        return uf.uf;
    }else if(pickerView == opcoesCidade){
        
        return [listaCidades objectAtIndex:row];;
    }
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == opcoesTpSang) {
        tipoSanguineo.text = [listaTpSanguineo objectAtIndex:row];
    }else if(pickerView == opcoesUF){
        listaCidades = nil;
        cidade.text = nil;
        UfCidades *uf =  [listaUfCidade objectAtIndex:row];
        UF.text = uf.uf;
        listaCidades = uf.cidades;
        cidade.text = [uf.cidades objectAtIndex:0];
    }else if(pickerView == opcoesCidade){
        cidade.text = [listaCidades objectAtIndex:row];
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
