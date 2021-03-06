//
//  AppDelegate.h
//  Instanote
//
//  Created by CMD on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
//    UITabBarController * tabBarController;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//the tabbarItems insert here
//@property (nonatomic, retain) UITabBarController * tabBarController;
@property (strong, nonatomic) JASidePanelController *viewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
