//
//  JYCadastroViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIPickerView *opcoesTpSang;
    NSArray *listaTpSanguineo;
    
    UIPickerView *opcoesQtdFilhos;
    NSArray *listaQtdFilhos;
    
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *CPF;
@property (weak, nonatomic) IBOutlet UITextField *dataNascimento;
@property (retain, nonatomic) IBOutlet UIDatePicker *listaData;
@property (weak, nonatomic) IBOutlet UITextField *tipoSanguineo;
@property (weak, nonatomic) IBOutlet UITextField *qtdFilhos;

@property (weak, nonatomic) IBOutlet UIScrollView *barraRolagem;



@end
