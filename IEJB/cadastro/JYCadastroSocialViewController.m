//
//  JYCadastroSocialViewController.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/09/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroSocialViewController.h"

@interface JYCadastroSocialViewController ()

@end

@implementation JYCadastroSocialViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
