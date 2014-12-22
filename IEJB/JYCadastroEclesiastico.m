//
//  JYCadastroEclesiastico.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 19/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroEclesiastico.h"
#import "XLForm.h"

@implementation JYCadastroEclesiastico

NSString *const kIgrejaOrigem = @"igrejaOrigem";
NSString *const kAnoConversao = @"anoConversao";
NSString *const kMotivoMudanca = @"motivoMudanca";
NSString *const kMinisterio = @"ministerio";
NSString *const kFuncao = @"funcao";
NSString *const kTrabDesenv = @"trabDesenv";

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
}

-(id)init
{
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Cadastro Eclesiástico"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Histórico"];
    [formDescriptor addFormSection:section];
    
    // Igreja de origem
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kIgrejaOrigem rowType:XLFormRowDescriptorTypeText title:@"Igreja de origem"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite a igreja" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Ano de conversão
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kAnoConversao rowType:XLFormRowDescriptorTypeNumber title:@"Ano de conversão"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o ano" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Motivo da mudanças
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMotivoMudanca rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"Motivo da mudança" forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Ministério"];
    [formDescriptor addFormSection:section];
    
    // Lista de ministérios
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMinisterio rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Ministério principal"];
    NSString *plistCaminho = [[NSBundle mainBundle]
                              pathForResource:@"ministerios"  ofType:@"plist"];
    
    row.selectorOptions = [NSArray
                           arrayWithContentsOfFile:plistCaminho];
    row.value = [row.selectorOptions objectAtIndex: 0];
    [section addFormRow:row];
    
    // Função
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFuncao rowType:XLFormRowDescriptorTypeNumber title:@"Função"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite a função" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    // Trabalhos desenvolvidos
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTrabDesenv rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"Trabalhos/Atividades desenvolvidas " forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    return [super initWithForm:formDescriptor];
    
}

@end
