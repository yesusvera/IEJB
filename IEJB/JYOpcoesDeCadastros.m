#import "XLForm.h"
#import "JYOpcoesDeCadastros.h"
#import "JYCadastroPessoal.h"
#import "JYCadastroEclesiastico.h"
#import "JYCadastroSocial.h"


NSString * const kCadastroPessoal = @"CadastroPessoal";
NSString * const kCadastroEclesiastico = @"CadastroEclesiastico";
NSString * const kCadastroSocial = @"CadastroSocial";

@interface JYOpcoesDeCadastros ()<UITableViewDataSource>

@end

@implementation JYOpcoesDeCadastros


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
    
    // Cadastro pessoal
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCadastroPessoal rowType:XLFormRowDescriptorTypeButton title:@"Pessoal"];
    row.buttonViewController = [JYCadastroPessoal class];
    [section addFormRow:row];
    
    // Cadastro Eclesiástico
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCadastroEclesiastico rowType:XLFormRowDescriptorTypeButton title:@"Eclesiástico"];
    row.buttonViewController = [JYCadastroEclesiastico class];
    [section addFormRow:row];
    
    // Cadastro Social
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCadastroSocial rowType:XLFormRowDescriptorTypeButton title:@"Social"];
    row.buttonViewController = [JYCadastroSocial class];
    [section addFormRow:row];
    
    
    self.form = form;
    
}



@end
