//
//  JYCadastroViewController.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 26/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroViewController.h"

@interface JYCadastroViewController ()

@end

@implementation JYCadastroViewController
@synthesize cadNome,cadCPF, cadDataNasc, listaData;

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
    // Do any additional setup after loading the view.
    //self.cadNome.layer.cornerRadius = 5.0f;
    //self.cadNome.layer.borderWidth = 0.3;
    // This allocates a label
    UILabel *prefixLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    //This sets the label text
    prefixLabel.text =@" Data de nascimento   ";
    // This sets the font for the label
    [prefixLabel setFont:[UIFont boldSystemFontOfSize:11]];
    // This fits the frame to size of the text
    [prefixLabel sizeToFit];
    self.cadDataNasc.leftView = prefixLabel;
    //It set when the left prefixLabel to be displayed
    cadNome.leftViewMode = UITextFieldViewModeAlways;
    
    // Criação do picker que irá substituir o teclado no campo de texto
    self.listaData = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 230, 0)];
    
    // Definir o modo do picker (data e hora, apenas datas, etc.)
    // Neste caso foi configurado para exibir apenas a data.
    self.listaData.datePickerMode = UIDatePickerModeDate;
    
    // Definir a ação que será executada como resposta ao evento do picker
    [self.listaData addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];

    
    // Ligar o picker ao campo de texto mediante a property inputView
    // Com isso estamos substituindo a entrada padrão do text field (teclado) pelo nosso picker

    self.cadDataNasc.inputView = listaData;
    

}

- (IBAction)fechaListaDatas:(UIButton *)sender {
    listaData.hidden = YES;
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
    self.cadDataNasc.text =[@"  Data de nascimento   " stringByAppendingString: [formatter stringFromDate:currentDate]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buscarData:(UITextField *)sender {
    listaData.hidden = NO;
}


@end
