//
//  ListsViewController.m
//  Instanote
//
//  Created by CMD on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListsViewController.h"
#import "UILabel+Extensions.h"

#define UserLoginInfo @"isLogin"

@implementation ListsViewController

@synthesize tableview;
@synthesize shakingshaking;
@synthesize inputTextField;
@synthesize managedObjectContext, fetchedResultsController;
@synthesize noteTempArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        //very import init
        if (managedObjectContext == nil) {
            managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        }        
        if (!noteTempArray) {
            noteTempArray = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self isGoLogin];
    
    UIBarButtonItem * addBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonSystemItemAdd target:self action:(@selector(ShakeWithSomething))];
    
    self.navigationItem.rightBarButtonItem = addBtn;
    
    [addBtn release];

    
    
    //core data
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    self.navigationItem.hidesBackButton = YES;
    
    if (!tableview) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480 - 44 - 44) style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview setBackgroundColor:[UIColor lightTextColor]];
        [self.view addSubview:tableview];
    }
    if (!emptydataView) {
        emptydataView = [[UIView alloc] init];
        [emptydataView setFrame:CGRectMake(0, 0, 320, 480)];
        [emptydataView setBackgroundColor:[UIColor lightTextColor]];
        
        UIButton * addsomething = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addsomething setFrame:CGRectMake(0, 160, 320, 100)];// icon size 30 and 30
        [addsomething addTarget:self action:(@selector(addWithAction)) forControlEvents:UIControlEventTouchUpInside];
        [emptydataView addSubview:addsomething];
        
        UILabel * descLabel = [[UILabel alloc] init];
        [descLabel setBackgroundColor:[UIColor clearColor]];
        [descLabel setText:@"Capture Somthing Before They are Gone..."];
        [descLabel setFont:[UIFont fontWithName:@"Arial" size:27]];
        [descLabel setFrame:CGRectMake(10, 260, 300, 50)];
        [descLabel setTextColor:[UIColor darkGrayColor]];
        [descLabel sizeToFitFixedWidth:300];
        [emptydataView addSubview:descLabel];
        [descLabel release];
        [emptydataView setHidden:YES];
        [self.view addSubview:emptydataView];
    }
    
    
    //shaking view
    if (!shakingshaking) {
        shakingshaking = [[ShakingView alloc] init];
        shakingshaking.delegate = self;
        [self.view addSubview:shakingshaking];
    }
    
    
    //background
    if (!mDisableViewOverlay) {
        mDisableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 89, 320, 317)];
        mDisableViewOverlay.backgroundColor=[UIColor blackColor];
        mDisableViewOverlay.alpha = 0; 
    }
    
    if (!tapgr) {
        tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignDisableViewOverlay)];
        [mDisableViewOverlay addGestureRecognizer:tapgr];
    }
    
    if (!inputTextField) {
        inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 54, 320, 25)];
        [inputTextField setDelegate:self];
        [inputTextField setEnablesReturnKeyAutomatically:YES];
    }
    
    [self fetch];
    
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
//        NSString *attributeName = @"name";
//        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name like %@", attributeName];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rank" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}    


/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[tableview beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = tableview;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:(BaseCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableview insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableview deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[tableview endUpdates];
}


- (void)isGoLogin
{
    //loginvc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * isLogin = [defaults objectForKey:UserLoginInfo];
    if ([isLogin length] <= 0) {
        LoginViewController * loginvc = [[LoginViewController alloc] init];
        [loginvc.navigationController.navigationBar setHidden:NO];
        [self.navigationController pushViewController:loginvc animated:NO];
        //[self presentModalViewController:loginvc animated:NO];
        [loginvc release];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    tableview = nil;
    emptydataView = nil;
    dateFormatter = nil;
    shakingshaking = nil;
    inputTextField = nil;
    //fetchedresultscontroller equals nil?
    //fetchedResultsController = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self isGoLogin];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    [self fetch];
    [shakingshaking becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    [fetchedResultsController release];
    [managedObjectContext release];
    [tableview release];
    [emptydataView release];
    [shakingshaking release];
    [inputTextField release];
    [dateFormatter release];
    [super dealloc];
}

#pragma mark - Core Data delegate

- (void)fetch {
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0]; 
    // get the list of items. Do it yourself
    if ([sectionInfo numberOfObjects] <= 1) {
        //show emptyview hidden tableview
        //[tableview removeFromSuperview];
        //[self.view addSubview:emptydataView];
        [emptydataView setHidden:NO];
        [tableview setHidden:YES];
    } else {
        //hidden emptyview, show tableview
        [tableview setHidden:NO];
        [emptydataView setHidden:YES];
        //before reloaddata fill the temp array
        [tableview reloadData];
        CGSize tableviewSize = self.view.frame.size;
        tableviewSize.height += 40;
        tableview.contentSize = tableviewSize;
    }
    
}


- (void)handleSaveNotification:(NSNotification *)aNotification {
    [managedObjectContext mergeChangesFromContextDidSaveNotification:aNotification];
    [self fetch];
}

#pragma mark - GestureRecognizer Selector

- (void)resignDisableViewOverlay
{
    [mDisableViewOverlay removeFromSuperview];
    [inputTextField resignFirstResponder];
    [inputTextField removeFromSuperview];
    [shakingshaking becomeFirstResponder];
}

#pragma mark - ShakingView delegate

- (void)ShakeWithSomething
{
    mDisableViewOverlay.alpha = 0;   
    [self.view addSubview:mDisableViewOverlay];
    [self.view addSubview:inputTextField];
    [inputTextField becomeFirstResponder];
    [UIView beginAnimations:@"FadeIn" context:nil];  
    [UIView setAnimationDuration:1.f];  
    mDisableViewOverlay.alpha = 0.6;  
    [UIView commitAnimations];
}

- (void)addWithAction
{
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark - TableView delegate

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell * cell = (BaseCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"cellheight is %f", cell.cellheight);
    return cell.cellheight;
}

//- (void)toDetailViewControllerByCakeInfo:(CakeInfo *)cakeinfo
//{
//    DetailViewController * detailvc = [[DetailViewController alloc] init];
//    detailvc.cakeinfo = cakeinfo;
//    [self.tabBarController setHidesBottomBarWhenPushed:YES];
//    [self.navigationController.navigationBar setHidden:NO];｀
//    [self.navigationController pushViewController:detailvc animated:YES];
//    [detailvc release];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
	//NSLog(@"section count is %i", count);
    return count;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    numberOfRows = [sectionInfo numberOfObjects];
    //NSLog(@"%i" , numberOfRows);
    return numberOfRows;
}

//- (NSString *)tableView:(UITableView *)table titleForHeaderInSection:(NSInteger)section { 
//    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
//    if ([fetchSectioningControl selectedSegmentIndex] == 0) {
//        return [NSString stringWithFormat:NSLocalizedString(@"Top %d songs", @"Top %d songs"), [sectionInfo numberOfObjects]];
//    } else {
//        return [NSString stringWithFormat:NSLocalizedString(@"%@ - %d songs", @"%@ - %d songs"), [sectionInfo name], [sectionInfo numberOfObjects]];
//    }
//}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)table {
//    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//    return [fetchedResultsController sectionIndexTitles];
//}

- (NSInteger)tableView:(UITableView *)table sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // tell table which section corresponds to section title/index (e.g. "B",1))
    return [fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    //Note *cellnote = [[fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    static NSString *kCellIdentifier = @"NoteCell";
    BaseCell *cell = [self.tableview dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    [self configureCell:cell atIndexPath:indexPath];
//    NSLog(@"indexpath of row index is %i", indexPath.row);
    return cell;
}


- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController * detailvc = [[DetailViewController alloc] init];
    detailvc.note = [fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:detailvc animated:YES];
    [detailvc release];
}



#pragma mark imp method
- (void)showNote:(Note *)note animated:(BOOL)animated 
{
    // Create a detail view controller, set the recipe, then push it.
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.note = note;
    
    [self.navigationController pushViewController:detailViewController animated:animated]; 
    [detailViewController release];
}

- (void)configureCell:(BaseCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
	Note *note = (Note *)[fetchedResultsController objectAtIndexPath:indexPath];
    cell.note = note;
    //NSLog(@"content is %@ and cellheight is %f and row is %i", note.content, cell.cellheight, indexPath.row);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
