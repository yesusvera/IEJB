//
//  JYCadastroEclesiasticoViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroEclesiasticoViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>{
    
    UIScrollView *barraRolagemEcles;

    NSArray *listaMinisterios;
    UIPickerView *opcoesMinisterios;
    
    NSMutableData *webData;
}
@property (weak, nonatomic) IBOutlet UITextField *anoConversao;
@property (weak, nonatomic) IBOutlet UITextField *igrejaOrigem;
@property (weak, nonatomic) IBOutlet UITextField *motivoMudanca;
@property (weak, nonatomic) IBOutlet UITextField *miniterio;
@property (weak, nonatomic) IBOutlet UITextField *funcao;
@property (weak, nonatomic) IBOutlet UITextField *trabDesenvolvidos;
@property(nonatomic, retain) NSMutableData *webData;

@end
