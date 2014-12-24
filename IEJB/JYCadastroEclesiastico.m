//
//  JYCadastroEclesiastico.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 19/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroEclesiastico.h"
#import "XLForm.h"
#import "JYCadastroSocial.h"

@implementation JYCadastroEclesiastico

NSString *const kIgrejaOrigem = @"igrejaOrigem";
NSString *const kAnoConversao = @"anoConversao";
NSString *const kMotivoMudanca = @"motivoMudanca";
NSString *const kMinisterio = @"ministerio";
NSString *const kFuncao = @"funcao";
NSString *const kTrabDesenv = @"trabDesenv";
NSString *const kEhBatizado = @"ehBatizado";
NSString *const kDtBatismo = @"dtBatismo";
NSString *const kBotaoSocial = @"botaoCadSocial";
NSString *const kBotaoConcluirCad2 = @"botaoConcluirCadastro2";

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
    
    // Ano de conversão
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kAnoConversao rowType:XLFormRowDescriptorTypeNumber title:@"Ano de conversão"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite o ano" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Opção se é batizado
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEhBatizado rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Batizado(a)?"];
    row.selectorOptions = @[@"Sim", @"Não"];
    row.value = @"Sim";
    [section addFormRow:row];
    
    // Ano de batismo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDtBatismo rowType:XLFormRowDescriptorTypeDateInline title:@"Data de batismo"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    
    // Igreja de origem
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kIgrejaOrigem rowType:XLFormRowDescriptorTypeText title:@"Igreja de origem"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite a igreja" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Motivo da mudanças
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMotivoMudanca rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"Motivo da mudança" forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Ministério"];
    [formDescriptor addFormSection:section];
    
    
    // É membro do ministério 1 a 1
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEhBatizado rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"É membro(a) do M1a1?"];
    row.selectorOptions = @[@"Sim", @"Não"];
    row.value = @"Sim";
    [section addFormRow:row];
    
    // Lista de ministérios
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMinisterio rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Ministério principal"];
    NSString *plistCaminho = [[NSBundle mainBundle]
                              pathForResource:@"ministerios"  ofType:@"plist"];
    
    row.selectorOptions = [NSArray
                           arrayWithContentsOfFile:plistCaminho];
    row.value = [row.selectorOptions objectAtIndex: 0];
    [section addFormRow:row];
    
    // Função
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFuncao rowType:XLFormRowDescriptorTypeNumber title:@"Função/Cargo"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfigAtConfigure setObject:@"Digite a função" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Trabalhos desenvolvidos
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTrabDesenv rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"Trabalhos/Atividades desenvolvidas " forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    // Ir para o cadastro eclesi[astico
    XLFormRowDescriptor * butaoIrSocial = [XLFormRowDescriptor formRowDescriptorWithTag:kBotaoSocial rowType:XLFormRowDescriptorTypeButton title:@"Cadastro Social"];
    [butaoIrSocial.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    butaoIrSocial.buttonViewController = [JYCadastroSocial class];
    //buttonRow.action.formSelector = @selector(didTouchButton:);
    [section addFormRow:butaoIrSocial];
    
    // Concluir o cadastro
    XLFormRowDescriptor * butaoConcluir = [XLFormRowDescriptor formRowDescriptorWithTag:kBotaoConcluirCad2 rowType:XLFormRowDescriptorTypeButton title:@"Concluir Cadastro"];
    [butaoConcluir.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    
    //buttonRow.action.formSelector = @selector(didTouchButton:);
    [section addFormRow:butaoConcluir];
    
    
    return [super initWithForm:formDescriptor];
    
}

@end
