//
//  JYTesteDeFormulario.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 10/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "XLForm.h"
#import "JYTesteDeFormulario.h"
//#import "DatesFormViewController.h"

NSString *const kName = @"nome";
NSString *const kCPF = @"CPF";
NSString *const kDates = @"Data";
NSString *const kTPSang = @"TPSang";
NSString *const kEmail = @"email";
NSString *const kTwitter = @"twitter";
NSString *const kNumber = @"number";
NSString *const kInteger = @"integer";
NSString *const kDecimal = @"decimal";
NSString *const kPassword = @"password";
NSString *const kPhone = @"phone";
NSString *const kUrl = @"url";
NSString *const kTextView = @"textView";
NSString *const kNotes = @"notes";

NSString *const kTiposSanguineos = @"tiposSanguineos";

NSString * const kTextFieldAndTextView = @"TextFieldAndTextView";

@implementation JYTesteDeFormulario


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dados Pessoais"];
    section.footerTitle = @"This is a long text that will appear on section footer";
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
    row.value = [NSDate new];
    [section addFormRow:row];
    
    
    // Tipo Sanguieno
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTiposSanguineos rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"Tipo Sanguíneo"];
    row.selectorOptions = @[@"O-",@"O+",@"A-",@"A+",@"B-",@"B+",@"AB-",@"AB+"];
    row.value = @"O-";
    
    [section addFormRow:row];
    
    
    
//    // Email
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeEmail title:@"Email"];
//    // validate the email
//    [row addValidator:[XLFormValidator emailValidator]];
//    [section addFormRow:row];
//    
//    // Twitter
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTwitter rowType:XLFormRowDescriptorTypeTwitter title:@"Twitter"];
//    row.disabled = YES;
//    row.value = @"@no_editable";
//    [section addFormRow:row];
//    
//    // Number
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNumber rowType:XLFormRowDescriptorTypeNumber title:@"Number"];
//    [section addFormRow:row];
//    
//    // Integer
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kInteger rowType:XLFormRowDescriptorTypeInteger title:@"Integer"];
//    [section addFormRow:row];
//    
//    // Decimal
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDecimal rowType:XLFormRowDescriptorTypeDecimal title:@"Decimal"];
//    [section addFormRow:row];
//    
//    // Password
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword rowType:XLFormRowDescriptorTypePassword title:@"Password"];
//    [section addFormRow:row];
//    
//    // Phone
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone rowType:XLFormRowDescriptorTypePhone title:@"Phone"];
//    [section addFormRow:row];
//    
//    // Url
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kUrl rowType:XLFormRowDescriptorTypeURL title:@"Url"];
//    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:section];
    
    
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextView rowType:XLFormRowDescriptorTypeTextView];
//    [row.cellConfigAtConfigure setObject:@"TEXT VIEW EXAMPLE" forKey:@"textView.placeholder"];
//    [section addFormRow:row];
//    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"TextView With Label Example"];
//    [formDescriptor addFormSection:section];
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNotes rowType:XLFormRowDescriptorTypeTextView title:@"Notes"];
//    [section addFormRow:row];
    
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



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

#pragma mark - Helper

-(void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Cadastro"];
    [form addFormSection:section];
    
//    // NativeEventFormViewController
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"realExamples" rowType:XLFormRowDescriptorTypeButton title:@"iOS Calendar Event Form"];
//    row.buttonViewController = [NativeEventNavigationViewController class];
//    [section addFormRow:row];
    
    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"This form is actually an example"];
//    section.footerTitle = @"ExamplesFormViewController.h, Select an option to view another example";
//    [form addFormSection:section];
    
    
    // TextFieldAndTextView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextFieldAndTextView rowType:XLFormRowDescriptorTypeButton title:@"Pessoal"];
    row.buttonViewController = [self class];
    [section addFormRow:row];
//    
//    // Selectors
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectors rowType:XLFormRowDescriptorTypeButton title:@"Selectors"];
//    row.buttonViewController = [SelectorsFormViewController class];
//    [section addFormRow:row];
//    
//    // Dates
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDates rowType:XLFormRowDescriptorTypeButton title:@"Dates"];
//    row.buttonViewController = [DatesFormViewController class];
//    [section addFormRow:row];
//    
//    // Others
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kOthes rowType:XLFormRowDescriptorTypeButton title:@"Other Rows"];
//    row.buttonViewController = [OthersFormViewController class];
//    [section addFormRow:row];
//    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multivalued example"];
//    [form addFormSection:section];
//    
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"MultiValued Sections"];
//    row.buttonViewController = [MultiValuedFormViewController class];
//    [section addFormRow:row];
//    
    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"UI Customization"];
//    [form addFormSection:section];
    
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"UI Customization"];
//    row.buttonViewController = [UICustomizationFormViewController class];
//    [section addFormRow:row];
    
    
    self.form = form;
    
}

@end
