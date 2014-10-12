//
//  JYCadastroPessoal.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 11/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//
#import "XLForm.h"
#import "JYCadastroPessoal.h"
#import "UfCidadeDao.h"
#import "UfCidades.h"

NSString *const kNome = @"nome";
NSString *const kCPF = @"CPF";
NSString *const kDataNascimento = @"dataNascimento";
NSString *const kTiposSanguineos = @"tiposSanguineos";
NSString *const kSexo = @"tiposSanguineos";
NSString *const kConjuge = @"conjuge";
NSString *const kFilhos = @"filhos";
NSString *const kRua = @"rua";
NSString *const kBairro = @"bairro";
NSString *const kUF = @"uf";
NSString *const kCidade = @"cidade";


@implementation JYCadastroPessoal

-(id)init
{
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Cadastro Pessoal"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dados Pessoais"];
    [formDescriptor addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNome rowType:XLFormRowDescriptorTypeText title:@"Nome"];
    row.required = YES;
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite seu nome" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // CPF
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCPF rowType:XLFormRowDescriptorTypeText title:@"CPF"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"000.000.000-00" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    // Data de nascimento
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDataNascimento rowType:XLFormRowDescriptorTypeDateInline title:@"Data de nascimento"];
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
    
    // Bloco dos filhos
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Filhos" multivaluedSection:YES];
    section.multiValuedTag = @"filhos";
    [formDescriptor addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFilhos rowType:XLFormRowDescriptorTypeText title:@"Filho " ];
    
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o nome" forKey:@"textField.placeholder"];
    
    [section addFormRow:row];
    
    
    
    // Bloco do Endereço
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Endereço"];
    [formDescriptor addFormSection:section];
    
    // Rua - Logradouro
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kRua rowType:XLFormRowDescriptorTypeText title:@"Rua - Logradouro"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite a Rua" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Bairro
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kBairro rowType:XLFormRowDescriptorTypeText title:@"Bairro"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o Bairro" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // UF
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kUF rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"UF"];
    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
    listaUfCidade = ufCidadeDao.buscarUfCidades;
    UfCidades *uf = [listaUfCidade objectAtIndex:0];
    row.value = uf.uf ;
    int i = 0;
    NSMutableArray *listaUf = [[NSMutableArray alloc]init];
    for (i = 0; i < listaUfCidade.count; i++) {
        
        uf = [listaUfCidade objectAtIndex:i];
        
        [listaUf addObject: uf.uf];
    }
    row.selectorOptions = listaUf;
    [section addFormRow:row];
    
    
    // Cidade
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCidade rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"Cidade"];
//    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
//    listaUfCidade = ufCidadeDao.buscarUfCidades;
//    UfCidades *uf = [listaUfCidade objectAtIndex:0];
//    row.value = uf.uf ;
//    int i = 0;
//    NSMutableArray *listaUf = [[NSMutableArray alloc]init];
//    for (i = 0; i < listaUfCidade.count; i++) {
//        
//        uf = [listaUfCidade objectAtIndex:i];
//        
//        [listaUf addObject: uf.uf];
//    }
//    row.selectorOptions = listaUf;
//    [section addFormRow:row];
    
    
    
    
    
    
    section = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:section];

    
    return [super initWithForm:formDescriptor];
    
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    [super didSelectFormRow:formRow];
    
    if ([formRow.tag isEqual:kUF]) {
        // do your thing for your row.
    }
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

/* Força o tamanho da célula para 44 em função de inconsistências no IOS8*/
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
