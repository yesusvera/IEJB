//
//  JYCadastroSocial.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 19/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYCadastroSocial.h"
#import "XLForm.h"
#import "ProfissoesDao.h"

@implementation JYCadastroSocial
NSString *const kProfissao = @"profissao";
NSString *const kGrauInstrucao = @"grauInstrucao";
NSString *const kOcupacaoAtual = @"ocupacaoAtual";
NSString *const kRenda = @"renda";
NSString *const kTemCasaPropria = @"casaPropria";
NSString *const kNecessidadeCurtoP = @"necessidadeCurtoPrazo";
NSString *const kNecessidadeMedioP = @"necessidadeMedioPrazo";
NSString *const kNecessidadeLongoP = @"necessidadeLongoPrazo";
NSString *const kBotaoConcluirCad3 = @"botaoConcluirCadastro3";

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
}

-(id)init
{
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Cadastro Social"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Profissional"];
    [formDescriptor addFormSection:section];
    
    // Lista de profissões
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kProfissao rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Profissão"];
    ProfissoesDao *profissoes = [[ProfissoesDao alloc]init];
    listaProfissoes = profissoes.buscarProfissoes;
    row.selectorOptions = listaProfissoes;
    row.value = [row.selectorOptions objectAtIndex: 422];
    [section addFormRow:row];
    
    // Lista de grau de instrução
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kGrauInstrucao rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Grau de instrução"];
    NSString *plistCaminhoGrauInstrucao = [[NSBundle mainBundle]
                                pathForResource:@"grauInstrucao"  ofType:@"plist"];
    row.selectorOptions = [NSArray arrayWithContentsOfFile:plistCaminhoGrauInstrucao];
    row.value = [row.selectorOptions objectAtIndex: 0];
    [section addFormRow:row];
    
    // Lista de ocupação atual
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kOcupacaoAtual rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Ocupação atual"];
    row.selectorOptions = listaProfissoes;
    row.value = [row.selectorOptions objectAtIndex: 422];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Financeiro"];
    [formDescriptor addFormSection:section];
    
    // Lista de rendas
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kRenda rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Grau de instrução"];
    NSString *plistCaminhoRendas = [[NSBundle mainBundle]
                                           pathForResource:@"rendas"  ofType:@"plist"];
    row.selectorOptions = [NSArray arrayWithContentsOfFile:plistCaminhoRendas];
    row.value = [row.selectorOptions objectAtIndex: 0];
    [section addFormRow:row];
    
    // Opção de casa propria
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTemCasaPropria rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Casa própria?"];
    row.selectorOptions = @[@"Sim", @"Não"];
    row.value = @"Sim";
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Necessidades"];
    [formDescriptor addFormSection:section];
    
    // De curto prazo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNecessidadeCurtoP rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"De curto prazo " forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    // De medio prazo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNecessidadeMedioP rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"De médio prazo " forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    // De longo prazo
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNecessidadeLongoP rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"De longo prazo " forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    // Concluir o cadastro
    XLFormRowDescriptor * butaoConcluir = [XLFormRowDescriptor formRowDescriptorWithTag:kBotaoConcluirCad3 rowType:XLFormRowDescriptorTypeButton title:@"Concluir Cadastro"];
    [butaoConcluir.cellConfig setObject:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    
    //buttonRow.action.formSelector = @selector(didTouchButton:);
    [section addFormRow:butaoConcluir];
    
    return [super initWithForm:formDescriptor];
    
}
@end
