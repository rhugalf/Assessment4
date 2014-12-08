//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;
@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
    
    //[self loadDogs];
    self.dogs = [self.personOwner.dogs allObjects];
    [self.dogsTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    self.dogs = [self.personOwner.dogs allObjects];
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dog *pupp = [self.dogs objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    //TODO: UPDATE THIS ACCORDINGLY
    cell.textLabel.text = pupp.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Breed: %@   Color: %@", pupp.breed, pupp.color];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *addDog = segue.destinationViewController;
        addDog.ownerSelected = self.personOwner;
    }
    else
    {

    }
}



@end
