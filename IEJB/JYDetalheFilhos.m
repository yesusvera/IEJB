//
//  JYDetalheFilhos.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 19/10/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYDetalheFilhos.h"
#import "XLForm.h"

@implementation JYDetalheFilhos

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
}

-(id)initWithForm:(XLFormDescriptor *)form
{
    return [super initWithForm:form];
}

@end
