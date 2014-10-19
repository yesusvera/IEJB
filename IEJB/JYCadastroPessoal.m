//
//  JYCadastroPessoal.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 11/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//
#import "XLForm.h"
#import "JYCadastroPessoal.h"
#import "JYDetalheFilhos.h"
#import "UfCidadeDao.h"
#import "UfCidades.h"

NSString *const kNome = @"nome";
NSString *const kCPF = @"CPF";
NSString *const kDataNasc = @"dataNascimento";
NSString *const kTiposSanguineos = @"tiposSanguineos";
NSString *const kSexo = @"sexo";
NSString *const kConjuge = @"conjuge";
NSString *const kQtdFilhos = @"qtdFilhos";
NSString *const kFilhos = @"filhos";
NSString *const kRua = @"rua";
NSString *const kBairro = @"bairro";
NSString *const kUF = @"uf";
NSString *const kCidade = @"cidade";
NSString *const kCep = @"CEP";
NSString *const kTelFixo = @"telFixo";
NSString *const kTelCel = @"telCel";
NSString *const kTelCom = @"telCom";

NSString *const kNomeFilho = @"nomeFilho";
NSString *const kDataNascFilho = @"dataNascFilho";
NSString *const kSexoFilho = @"sexoFilho";



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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDataNasc rowType:XLFormRowDescriptorTypeDateInline title:@"Data de nascimento"];
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
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQtdFilhos rowType:XLFormRowDescriptorTypeStepCounter title:@"Qtd Filhos"];
    [section addFormRow:row];
    
    // TextFieldAndTextView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFilhos rowType:XLFormRowDescriptorTypeButton title:@"Detalhar Filhos"];
    row.buttonViewController = [JYDetalheFilhos class];
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
    
    //UF
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kUF rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"UF"];
    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
    row.selectorOptions = [ufCidadeDao buscarUfs];
    row.value = [row.selectorOptions objectAtIndex:6];
    [section addFormRow:row];
    
    //Cidade
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCidade rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Cidades"];
    row.selectorOptions = [ufCidadeDao buscarCidadesPor:(int)[self buscarPosicaoAtualNa:section doCampo:kUF] + 1];
    row.value = [row.selectorOptions objectAtIndex: 0];
    [section addFormRow:row];
    
    // CEP
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCep rowType:XLFormRowDescriptorTypePhone title:@"CEP"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"00.000-000" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    
    // Bloco dos contatos
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Contatos"];
    [formDescriptor addFormSection:section];
    
    // Fixo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTelFixo rowType:XLFormRowDescriptorTypePhone title:@"Fixo"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"(00) 0000-0000" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Celular
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTelCel rowType:XLFormRowDescriptorTypePhone title:@"Celular"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"(00) 0000-0000" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Comercial
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTelCom rowType:XLFormRowDescriptorTypePhone title:@"Comercial"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"(00) 0000-0000" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    
    return [super initWithForm:formDescriptor];
    
}


-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow{
    if ([formRow.tag isEqualToString:kFilhos]) {
        double qtd = 0;
        for (XLFormRowDescriptor * row in formRow.sectionDescriptor.formRows) {
            if (row.tag && [row.tag isEqualToString:kQtdFilhos]){
                qtd = [row.value doubleValue];
            }
        }
        
        XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Filhos"];
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
    
        formDescriptor.assignFirstResponderOnShow = YES;
    
        for (int i = 1; i <= qtd; i++) {
        
            // Basic Information - Section
            section = [XLFormSectionDescriptor formSectionWithTitle:[@"Dados do filho " stringByAppendingString:@(i).stringValue]];
            [formDescriptor addFormSection:section];
        
        
            // Name
            row = [XLFormRowDescriptor formRowDescriptorWithTag:[kNomeFilho stringByAppendingString:@(i).stringValue] rowType:XLFormRowDescriptorTypeText title:@"Nome"];
            [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
            [row.cellConfigAtConfigure setObject:@"Digite o nome" forKey:@"textField.placeholder"];
            [section addFormRow:row];
        
            // Data de nascimento
            row = [XLFormRowDescriptor formRowDescriptorWithTag:[kDataNascFilho stringByAppendingString:@(i).stringValue]  rowType:XLFormRowDescriptorTypeDateInline title:@"Data de nascimento"];
            row.value = [NSDate new];
            [section addFormRow:row];
        
        
            // Opções de sexo
            row = [XLFormRowDescriptor formRowDescriptorWithTag:[kSexoFilho stringByAppendingString:@(i).stringValue]  rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Sexo"];
            row.selectorOptions = @[@"Masculino", @"Feminino"];
            row.value = @"Masculino";
            [section addFormRow:row];
        }
    
        JYDetalheFilhos *filhos = [[JYDetalheFilhos alloc] initWithForm:formDescriptor];
    
        [self.navigationController pushViewController:filhos animated:YES];
    }
}


-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    //[self reloadFormRow:rowDescriptor];
    if ([rowDescriptor.tag isEqualToString:kUF]) {
        
        if (![rowDescriptor.value isEqualToString: oldValue]){

            for (XLFormRowDescriptor * row in rowDescriptor.sectionDescriptor.formRows) {
                if (row.tag && [row.tag isEqualToString:kCidade]){
                    UfCidadeDao *ufCidadeDao = [[UfCidadeDao alloc]init];
                    row.selectorOptions = [ufCidadeDao buscarCidadesPor:(int)[self buscarPosicaoAtualNa:rowDescriptor.sectionDescriptor doCampo:kUF] + 1];
                    row.value = [row.selectorOptions objectAtIndex: 0];
                }
            }
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
        self.tableView.rowHeight = 44;
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
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}

- (long) buscarPosicaoAtualNa: (XLFormSectionDescriptor *) secao doCampo:(NSString *) campo{
    for (XLFormRowDescriptor * row in secao.formRows) {
        if (row.tag && [row.tag isEqualToString:campo]){
            return  [row.selectorOptions indexOfObject:[row value]];
        }
    }
    return 0;
}

@end
