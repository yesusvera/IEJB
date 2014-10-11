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
@synthesize anoConversao, igrejaOrigem, motivoMudanca, miniterio, funcao, trabDesenvolvidos;

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
