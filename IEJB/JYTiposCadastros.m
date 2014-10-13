//
//  JYTesteDeFormulario.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 10/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//
#import "JYCadastroPessoal.h"
#import "JYTiposCadastros.h"
#import "XLForm.h"

NSString * const kCadastroPessoal = @"CadastroPessoal";

@interface JYTiposCadastros ()

@end

@implementation JYTiposCadastros


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

// Mostrando a barra de navegação
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

#pragma mark - Helper

-(void)initializeForm
{

    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Cadastro"];
    [form addFormSection:section];
    
    
    // TextFieldAndTextView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCadastroPessoal rowType:XLFormRowDescriptorTypeButton title:@"Pessoal"];
    row.buttonViewController = [JYCadastroPessoal class];
    [section addFormRow:row];
    
    
    self.form = form;
    
}



@end
