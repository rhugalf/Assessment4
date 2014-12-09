//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "DogOwner.h"
#import "Person.h"
#import "ColorUser.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@property (nonatomic)  NSArray *dogOwners;
@property (nonatomic)  NSMutableArray *persons;
@property (nonatomic)  ColorUser *colorFav;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    self.persons = [[NSMutableArray alloc] init];
   
    DogOwner *dogOwn = [[DogOwner alloc] init];
    
    dogOwn.managedObjectContext = self.managedObjectContext;
    
        [dogOwn retrieveListOwnersWithCompletion:^(NSArray *dogowners) {
        self.dogOwners = dogowners;
        [self.myTableView reloadData];
        }];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ColorUser"];
   // request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"colorRValue" ascending:YES]];
    NSError *error;

    ColorUser *cu = [self.managedObjectContext executeFetchRequest:request error:&error].lastObject;
    
    if (cu) {
        UIColor *col = [[UIColor alloc] initWithRed:[cu.colorRValue floatValue]  green:[cu.colorGValue floatValue] blue:[cu.colorBValue floatValue] alpha:[cu.colorAValue floatValue]];
        
        self.navigationController.navigationBar.tintColor = col;
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Person *person = [self.dogOwners objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
    DogsViewController *dogsViewController = segue.destinationViewController;
    dogsViewController.personOwner  = person;
}



#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.dogOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *owner = [self.dogOwners objectAtIndex:indexPath.row];
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
    [self storeColor];

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

-(void)storeColor{
    UIColor *c = self.navigationController.navigationBar.tintColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    const CGFloat *components = CGColorGetComponents(c.CGColor);
    red = components[0];
    green = components[1];
    blue = components[2];
    alpha = components[3];
    
    ColorUser *color = [NSEntityDescription  insertNewObjectForEntityForName:@"ColorUser" inManagedObjectContext:self.managedObjectContext];
    color.colorRValue = [NSNumber numberWithFloat:red];
    color.colorGValue = [NSNumber numberWithFloat:green];
    color.colorBValue = [NSNumber numberWithFloat:blue];
    color.colorAValue = [NSNumber numberWithFloat:alpha];
    
    [self.managedObjectContext save:nil];
}

@end
