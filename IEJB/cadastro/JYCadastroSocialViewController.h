//
//  JYCadastroSocialViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroSocialViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>{
    
    UIScrollView *barraRolagemSocial;
    
    NSArray *listaRendas;
    UIPickerView *opcoesRendas;
    
    NSArray *listaGrauInstrucao;
    UIPickerView *opcoesGrauInstrucao;
    
    NSArray *listaProfissoes;
    UIPickerView *opcoesProfissoes;
}
@property (weak, nonatomic) IBOutlet UITextField *profissao;
@property (weak, nonatomic) IBOutlet UITextField *grauIntrucao;
@property (weak, nonatomic) IBOutlet UITextField *renda;
@property (weak, nonatomic) IBOutlet UISegmentedControl *temCasaPropria;
@property (weak, nonatomic) IBOutlet UITextField *necessidadeCurtoPrazo;
@property (weak, nonatomic) IBOutlet UITextField *necessidadeMedioPrazo;
@property (weak, nonatomic) IBOutlet UITextField *necessidadeLongoPrazo;

@end
