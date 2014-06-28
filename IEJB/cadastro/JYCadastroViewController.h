//
//  JYCadastroViewController.h
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCadastroViewController : UIViewController<UITextFieldDelegate>{
}
@property (weak, nonatomic) IBOutlet UITextField *cadNome;
@property (weak, nonatomic) IBOutlet UITextField *cadCPF;
@property (weak, nonatomic) IBOutlet UITextField *cadDataNasc;
@property (retain, nonatomic) IBOutlet UIDatePicker *listaData;




@end
