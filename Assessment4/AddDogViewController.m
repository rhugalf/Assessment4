//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;


@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    Dog *pup = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.ownerSelected.managedObjectContext];
    pup.name = self.nameTextField.text;
    pup.breed = self.breedTextField.text;
    pup.color = self.colorTextField.text;
    
    
    [self.ownerSelected addDogsObject:pup];
    
    [self.ownerSelected.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
