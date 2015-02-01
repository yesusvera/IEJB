//
//  JYCadastroPessoal.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 11/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroPessoal.h"
#import "XLForm.h"
#import "JYDetalheFilhos.h"
#import "UfCidadeDao.h"
#import "UfCidades.h"
#import "JYCadastroEclesiastico.h"

NSString *const kNome = @"nome";
NSString *const kCPF = @"CPF";
NSString *const kDataNasc = @"dataNascimento";
NSString *const kTiposSanguineos = @"tiposSanguineos";
NSString *const kDoencas = @"doencas";
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

NSString *const kEmail = @"email";
NSString *const kUsuario = @"usuario";
NSString *const kSenha1 = @"senha1";
NSString *const kSenha2 = @"senha2";

NSString *const kNomeFilho = @"nomeFilho";
NSString *const kDataNascFilho = @"dataNascFilho";
NSString *const kSexoFilho = @"sexoFilho";


NSString *const kBotaoEcles = @"botaoEcles";
NSString *const kBotaoConcluirCad = @"botaoConcluirCad";



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
    
    // Detalhar filhos
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFilhos rowType:XLFormRowDescriptorTypeButton title:@"Detalhar Filhos"];
    [row.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    //row.buttonViewController = [JYDetalheFilhos class];
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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCidade rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Cidade"];
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
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Saúde"];
    [formDescriptor addFormSection:section];
    
    
    // Tipo Sanguieno
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTiposSanguineos rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Tipo Sanguíneo"];
    row.selectorOptions = @[@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+"];
    row.value = @"O-";
    [section addFormRow:row];
    
    // Doenças e/ou necessidades especiais
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoencas rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"Doenças e/ou necessidades especiais" forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"E-mail"];
    [formDescriptor addFormSection:section];
    
    
    // Email
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeEmail];
    [row addValidator:[XLFormValidator emailValidator]];
    [row.cellConfigAtConfigure setObject:@"Informe o seu E-mail" forKey:@"textField.placeholder"];
    
    //[row addValidator:[XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Usuário"];
    [formDescriptor addFormSection:section];
    
    // Usuário
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kUsuario rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Informe seu usuário" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Senha"];
    [formDescriptor addFormSection:section];
    
    // Senha
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSenha1 rowType:XLFormRowDescriptorTypePassword];
    [row.cellConfigAtConfigure setObject:@"Informe sua senha" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Confirmar senha"];
    [formDescriptor addFormSection:section];
    
    // Confirmar senha
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSenha2 rowType:XLFormRowDescriptorTypePassword];
    [row.cellConfigAtConfigure setObject:@"Informe novamente a sua senha" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    // Ir para o cadastro eclesi[astico
    XLFormRowDescriptor * butaoIrEcle = [XLFormRowDescriptor formRowDescriptorWithTag:kBotaoEcles rowType:XLFormRowDescriptorTypeButton title:@"Cadastro Eclesiástico"];
    [butaoIrEcle.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    [butaoIrEcle.cellConfig setObject:@(NSTextAlignmentCenter) forKey:@"textLabel.textAlignment"];
    [butaoIrEcle.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    butaoIrEcle.buttonViewController = [JYCadastroEclesiastico class];
    //[butaoIrEcle.action.formSelector = @selector(didTouchButton:)];
    
    [section addFormRow:butaoIrEcle];
    
    // Concluir o cadastro
    XLFormRowDescriptor * butaoConcluir = [XLFormRowDescriptor formRowDescriptorWithTag:kBotaoConcluirCad rowType:XLFormRowDescriptorTypeButton title:@"Concluir Cadastro"];
    [butaoConcluir.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    butaoConcluir.cellConfig.accessibilityLabel = UITableViewCellStyleDefault;
    //[butaoConcluir.cellConfig setObject:[UITableViewCellStyleDefault ] forKey:@"textLabel.aling"];
    butaoConcluir.action.formSelector = @selector(didTouchButton:);
    [section addFormRow:butaoConcluir];

    
    return [super initWithForm:formDescriptor];
    
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow{
    
    [super didSelectFormRow:formRow];

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
    } else if ([formRow.tag isEqualToString:kBotaoConcluirCad]){

        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Deseja concluir o cadastro?"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Não"
                              otherButtonTitles:@"Sim", nil];
        [alert show];
    }
   

}


-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
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
    }else if ([rowDescriptor.tag isEqualToString:kCPF]){
        // Falta implementar para incluir a mascara dinamicamente.
//        if([rowDescriptor.value isEqualToString:oldValue]){
//            return;
//        }
//        
//        NSString *valor = rowDescriptor.value;
//
//        if(valor.length == 3 || valor.length == 7) {
//            NSString *str = [NSString stringWithFormat:@"%@.",valor];
//            rowDescriptor.value = str;
//        }
//        
//        if(valor.length == 11){
//            NSString *str = [NSString stringWithFormat:@"%@-", valor];
//            rowDescriptor.value = str;
//        }
//        
//        if(valor.length == 14){
//            return;
//        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
   
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];

    self.tableView.rowHeight = 44;
   // self.form.delegate = self;
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger) buttonIndex{
    
    if (buttonIndex == 1) {
        // TODO: Validação de campos
//            NSArray * validationErrors = [self formValidationErrors];
//            if (validationErrors.count > 0){
//                [self showFormValidationError:[validationErrors firstObject]];
//                return;
//            }
//            [self.tableView endEditing:YES];
//            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil) message:@"No errors found" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//            [alertView show];
        
        
        
        NSLog(@"Entrou", nil);
    }
}


//-(IBAction)savePressed:(UIBarButtonItem * __unused)button
//{
//    NSArray * validationErrors = [self formValidationErrors];
//    if (validationErrors.count > 0){
//        [self showFormValidationError:[validationErrors firstObject]];
//        return;
//    }
//    [self.tableView endEditing:YES];
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil) message:@"No errors found" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//    [alertView show];
//}

- (long) buscarPosicaoAtualNa: (XLFormSectionDescriptor *) secao doCampo:(NSString *) campo{
    for (XLFormRowDescriptor * row in secao.formRows) {
        if (row.tag && [row.tag isEqualToString:campo]){
            return  [row.selectorOptions indexOfObject:[row value]];
        }
    }
    return 0;
}

-(void)didTouchButton:(XLFormRowDescriptor *)sender
{
    if ([sender.tag isEqualToString:kBotaoConcluirCad]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Switch is ON", nil) message:@"Button has checked the switch value..." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
    }
    [self deselectFormRow:sender];
}

@end
