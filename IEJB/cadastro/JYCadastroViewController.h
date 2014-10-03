//
//  JYCadastroViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>{
    
    NSArray *listaTpSanguineo;
    NSArray *listaUfCidade;
    NSArray *listaCidades;
    
    UIDatePicker *listaData;
    
    UIPickerView *opcoesTpSang;
    UIPickerView *opcoesUF;
    UIPickerView *opcoesCidade;
    
    NSString *idCidade;
    
}
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *CPF;
@property (weak, nonatomic) IBOutlet UITextField *dataNascimento;
@property (weak, nonatomic) IBOutlet UITextField *tipoSanguineo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexo;
@property (weak, nonatomic) IBOutlet UITextField *conjuge;
@property (weak, nonatomic) IBOutlet UITextField *qtdFilhos;
@property (weak, nonatomic) IBOutlet UITextField *ruaLogradouro;
@property (weak, nonatomic) IBOutlet UITextField *bairro;
@property (weak, nonatomic) IBOutlet UITextField *UF;
@property (weak, nonatomic) IBOutlet UITextField *cidade;
@property (weak, nonatomic) IBOutlet UITextField *cep;
@property (weak, nonatomic) IBOutlet UITextField *telFixo;
@property (weak, nonatomic) IBOutlet UITextField *telCelular;
@property (weak, nonatomic) IBOutlet UITextField *telComercial;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *usuario;
@property (weak, nonatomic) IBOutlet UITextField *senha;
@property (weak, nonatomic) IBOutlet UITextField *confirmaSenha;
@property (weak, nonatomic) IBOutlet UIScrollView *barraRolagem;

- (IBAction)validarCEP:(id)sender;

@end
