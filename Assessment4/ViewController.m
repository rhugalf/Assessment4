//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogOwner.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@property (nonatomic)  NSArray *dogOwners;
@property (nonatomic)  NSMutableArray *persons;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    self.persons = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"tableViewPopulated"]) {
        
        [DogOwner retrieveDogOwnersWithCompletion:^(NSArray *dogowners) {
        self.dogOwners = dogowners;
        }];
        
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"tableViewPopulated"];
        [defaults synchronize];
    }
    [self loadData];
}

- (IBAction)onAddOwner:(UITextField *)sender {
    NSLog(@"adding...");
    
    NSManagedObject *owner =[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [owner setValue:sender.text forKey:@"name"];

    [self.managedObjectContext save:nil];
    [self loadData];
    
    sender.text=@"";
    [sender resignFirstResponder];
    
}

-(void)loadData{
    NSFetchRequest *request =[[NSFetchRequest alloc]initWithEntityName:@"Person"];

    NSArray *localP =[self.managedObjectContext executeFetchRequest:request error:nil];
    [self.persons addObjectsFromArray:localP];
    [self.myTableView reloadData];
}

-(void)setDogOwners:(NSArray *)dogOwners{
    _dogOwners = dogOwners;
    [self.myTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.persons.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DogOwner *owner = [self.persons objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    //TODO: UPDATE THIS ACCORDINGLY
    cell.textLabel.text = owner.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
