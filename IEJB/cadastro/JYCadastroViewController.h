//
//  JYCadastroViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>{
    
    UIPickerView *opcoesTpSang;
    NSArray *listaTpSanguineo;
    
    UIDatePicker *listaData;
    
    UIScrollView *barraRolagem;

    
}
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *CPF;
@property (weak, nonatomic) IBOutlet UITextField *dataNascimento;
@property (weak, nonatomic) IBOutlet UITextField *tipoSanguineo;
@property (weak, nonatomic) IBOutlet UITextField *qtdFilhos;


@end
