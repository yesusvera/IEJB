//
//  JYCadastroPessoal.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 11/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//
#import "XLForm.h"
#import "JYCadastroPessoal.h"

NSString *const kName = @"nome";
NSString *const kCPF = @"CPF";
NSString *const kDates = @"dataNascimento";
NSString *const kTiposSanguineos = @"tiposSanguineos";
NSString *const kSexo = @"tiposSanguineos";
NSString *const kConjuge = @"conjuge";
NSString *const kFilhos = @"filhos";

@implementation JYCadastroPessoal

-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dados Pessoais"];
    [formDescriptor addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@"Nome"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite seu nome" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // CPF
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCPF rowType:XLFormRowDescriptorTypeText title:@"CPF"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"000.000.000-00" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    // Data de nascimento
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDates rowType:XLFormRowDescriptorTypeDateInline title:@"Data de nascimento"];
    row.required = YES;
    row.value = [NSDate new];
    [section addFormRow:row];
    
    
    // Tipo Sanguieno
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTiposSanguineos rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Tipo Sanguíneo"];
    row.selectorOptions = @[@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+"];
    row.value = @"O-";
    
    [section addFormRow:row];
    
    
    // Opções de sexo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSexo rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Sexo"];
    row.selectorOptions = @[@"Masculino", @"Feminino"];
    row.value = @"Masculino";
    [section addFormRow:row];
    
    
    // Conjuge
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kConjuge rowType:XLFormRowDescriptorTypeText title:@"Cônjuge"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o nome do cônjuge" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:section];
    
    // Another one
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Filhos" multivaluedSection:YES];
    section.multiValuedTag = @"filhos";
    [formDescriptor addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFilhos rowType:XLFormRowDescriptorTypeText title:@"Filho " ];
    
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o nome" forKey:@"textField.placeholder"];
    
    
    [section addFormRow:row];
    
    
    return [super initWithForm:formDescriptor];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}


-(IBAction)savePressed:(UIBarButtonItem * __unused)button
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil) message:@"No errors found" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alertView show];
}

@end
