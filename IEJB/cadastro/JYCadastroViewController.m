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
@synthesize nome,CPF, dataNascimento, listaData,barraRolagem,tipoSanguineo,qtdFilhos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //hide keyboard on touch of scroll view
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.barraRolagem addGestureRecognizer:yourTap];
    
    
    self.listaData = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 230, 0)];
    self.listaData.datePickerMode = UIDatePickerModeDate;
    [self.listaData addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];
    [self.listaData removeFromSuperview];
    self.dataNascimento.inputView = listaData;
    
    
    
    listaTpSanguineo = [[NSArray alloc] initWithObjects:@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+", nil];
    opcoesTpSang= [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    [tipoSanguineo setDelegate: self];
    tipoSanguineo.inputView = opcoesTpSang;
    //tipoSanguineo.text = [listaTpSanguineo objectAtIndex:0];
    [opcoesTpSang setDelegate:self];
    
    
//    listaQtdFilhos = [[NSArray alloc] initWithObjects:@"O",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
//    opcoesQtdFilhos= [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
//    [qtdFilhos setDelegate: self];
//    qtdFilhos.inputView = opcoesQtdFilhos;
//    qtdFilhos.text = [listaQtdFilhos objectAtIndex:0];
//    [opcoesQtdFilhos setDelegate:self];
    
    
    
    [self.barraRolagem setScrollEnabled:YES];
    [self.barraRolagem setContentSize:CGSizeMake(320, 1624)];
    
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
    
    // Dispose of any resources that can be recreated.
}


//hide keyboard on touch of scroll view
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer {
    
    //make keyboard disappear , you can use resignFirstResponder too, it's depend.
    [self.view endEditing:YES];
}



#pragma mark - UIPickerView Delegate

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [listaTpSanguineo count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [listaTpSanguineo objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    tipoSanguineo.text = [listaTpSanguineo objectAtIndex:row];
}

@end
