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
#import "Cidade.h"
#import "GLB.h"
#import "CWSBrasilValidate.h"
@interface JYCadastroViewController ()
@property(nonatomic) UITextField *activeField;
@end

@implementation JYCadastroViewController



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
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    // unregister for keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Comando para fechar os componentes na Scrool Vew. Ex: Teclado, PickerView, DatePickerView. etc...
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.barraRolagem addGestureRecognizer:yourTap];
    [self.barraRolagem setScrollEnabled:YES];
    [self.barraRolagem setContentSize:CGSizeMake(320, 1470)];
    
    //DataPickerView da data de nascimento
    listaData = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 230, 0)];
    listaData.datePickerMode = UIDatePickerModeDate;
    [listaData addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];
    [listaData removeFromSuperview];
    self.dataNascimento.inputView = listaData;
    
    
    //PickerView com as opções de tipo sanquineo
    listaTpSanguineo = [[NSArray alloc] initWithObjects:@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+", nil];
    opcoesTpSang = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesTpSang setDelegate:self];
    [opcoesTpSang setDataSource:self];
    self.tipoSanguineo.inputView = opcoesTpSang;
    
    //Setando o campo qtdFilhos com o valor padrão zero
    self.qtdFilhos.text = @"0";
    
    //PickerView com as opções de UF
    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
    listaUfCidade = ufCidadeDao.buscarUfCidades;
    opcoesUF = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesUF setDelegate:self];
    [opcoesUF setDataSource:self];
    self.UF.inputView = opcoesUF;
    
    //PickerView com as opções de Cidade
    opcoesCidade = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [opcoesCidade setDelegate:self];
    [opcoesCidade setDataSource:self];
    self.cidade.inputView = opcoesCidade;
    
    
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
    self.dataNascimento.text =[formatter stringFromDate:currentDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//Compando para controlar os componentes na ScroolView
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer {
    
    [self.view endEditing:YES];
    [_activeField resignFirstResponder];
}

// Confirma com o usuário se quer realmente concluir o cadastro.
- (IBAction)concluirCadastro:(id)sender {
    
    Membro *membro = [[Membro alloc]init];
    
    membro.nome = self.nome.text;
    membro.CPF = self.CPF.text;
    membro.dataNascimento = self.dataNascimento.text;
    membro.tipoSanguineo = self.tipoSanguineo.text;
    membro.sexo          = self.sexo.textInputContextIdentifier;
    membro.conjuge     = self.conjuge.text;
    membro.qtdFilhos = self.qtdFilhos.text;
    membro.ruaLogradouro = self.ruaLogradouro.text;
    membro.bairro   = self.bairro.text;
    membro.UF = self.UF.text;
    membro.cidade = self.cidade.text;
    membro.cep = self.cep.text;
    membro.telFixo = self.telFixo.text;
    membro.telCelular = self.telCelular.text;
    membro.telComercial = self.telComercial.text;
    membro.email = self.email.text;
    membro.usuario = self.usuario.text;
    membro.senha = self.senha.text;
    membro.confirmaSenha = self.confirmaSenha.text;
    membro.idCidade = idCidade;
    
    ConexaoCadastrarMembro *cadMembro = [[ConexaoCadastrarMembro alloc]init];
    
    [cadMembro cadastrarMembro:membro];
}


// Metodo do para incrementar a quantidade de filhos
- (IBAction)incrementarFilhos:(id)sender {
    
    UIStepper *incrementador = (UIStepper *)sender;
    self.qtdFilhos.text = [NSString stringWithFormat:@"%d",
                           (int)incrementador.value];
}


#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            break;
        case 2:
            //concluiCad = YES;
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
        Cidade *cidadeEscolhida = [listaCidades objectAtIndex:row];
        return cidadeEscolhida.nome;
    }
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == opcoesTpSang) {
        self.tipoSanguineo.text = [listaTpSanguineo objectAtIndex:row];
    }else if(pickerView == opcoesUF){
        listaCidades = nil;
        self.cidade.text = nil;
        UfCidades *uf =  [listaUfCidade objectAtIndex:row];
        self.UF.text = uf.uf;
        listaCidades = uf.cidades;
        
        Cidade *cidadePrinc = [listaCidades objectAtIndex:0];
        self.cidade.text = cidadePrinc.nome;
        idCidade  = cidadePrinc.id;
    }else if(pickerView == opcoesCidade){
        Cidade *cidadeEscolhida = [listaCidades objectAtIndex:row];
        self.cidade.text = cidadeEscolhida.nome;
        idCidade  = cidadeEscolhida.id;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.CPF){
        if(string.length == 0){
            return YES;
        }
        
        if(range.location == 3 || range.location == 7) {
            NSString *str = [NSString stringWithFormat:@"%@.",textField.text];
            textField.text = str;
        }
        
        if(range.location == 11){
            NSString *str = [NSString stringWithFormat:@"%@-", textField.text];
            textField.text = str;
        }
        
        if(range.location == 14){
            return NO;
        }
    }
    
    if (textField == self.telCelular || textField == self.telComercial || textField == self.telFixo){
        if(string.length == 0){
            return YES;
        }
        
        if(range.location == 0){
            NSString *str = [NSString stringWithFormat:@"%@(", textField.text];
            textField.text = str;
        }
        
        if(range.location == 3){
            NSString *str = [NSString stringWithFormat:@"%@)", textField.text];
            textField.text = str;
        }
        
        if(range.location == 8){
            NSString *str = [NSString stringWithFormat:@"%@-", textField.text];
            textField.text = str;
        }
        
        if(range.location == 13){
            return NO;
        }
    }
    
    if (textField == self.cep){
        if(string.length == 0){
            return YES;
        }
        
        if(range.location == 2){
            NSString *str = [NSString stringWithFormat:@"%@.", textField.text];
            textField.text = str;
        }
        
        if(range.location == 6){
            NSString *str = [NSString stringWithFormat:@"%@-", textField.text];
            textField.text = str;
        }
        
        if(range.location == 9){
            return NO;
        }
    }
    return YES;
}

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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
    if (textField == self.CPF){
        
        if (![CWSBrasilValidate validarCPF:[[textField.text stringByReplacingOccurrencesOfString:@"." withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""]]) {
            
            [GLB showMessage:@"CPF Inválido!"];
        }
    }
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect aRect = self.view.bounds;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
        
        CGRect bkgndRect = _activeField.superview.frame;
        
        bkgndRect.size.height += kbSize.height;
        
        [_activeField.superview setFrame:bkgndRect];
        
        [_barraRolagem setContentOffset:CGPointMake(0.0, _activeField.frame.origin.y-kbSize.height + 40) animated:YES];
        
    }
    
}

// Called when the UIKeyboardWillHideNotification is received
- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    // scroll back..
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.barraRolagem.contentInset = contentInsets;
    
    self.barraRolagem.scrollIndicatorInsets = contentInsets;
}

@end
