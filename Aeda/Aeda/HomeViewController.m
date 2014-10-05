//
//  HomeViewController.m
//  Allianz
//
//  Created by Jonathan Banga on 28/7/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+ALColor.h"
#import "HomeMenuHeaderTableView.h"
#import "UIFont+ALFonts.h"
#import "HomeMenuHeaderItem.h"
#import "MisDatosViewController.h"
#import "LoginViewController.h"
#import "UserManager.h"
#import "ButtonsTableViewCell.h"
#import "SupressFunction.h"

#import "RutinaViewController.h"

#define kText @"kText"
#define kImageName @"kImageName"
#define kSelectorName @"kSelectorName"
#define kCellIdentifier @"kHomeCellIdentifier"
#define kSocialCellIdentifier @"kSocialCellIdentifier"

@interface HomeViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) NSArray* dataArray;
@property (nonatomic, strong) HomeMenuHeaderTableView* headerView;

//ViewControllers
@property(nonatomic,strong)UIAlertView *alertSOS;
@property(nonatomic,strong)UIAlertView *alertContactarAllianz;
@property(nonatomic,strong)UIAlertView *alertAuxilioMecanico;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArray = @[
                           @{kText: @" Mi ubicación", kImageName: @"Mi Ubicacion", kSelectorName: @"showMyLocation"},
                           @{kText: @"Información útil", kImageName: @"Informacion Util", kSelectorName: @"showUtilInformation"},
                           @{kText: @"Sitio institucional", kImageName: @"Sitio Institucional", kSelectorName: @"showInstitutionalSite"},
                           ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogged:) name:kMensajesLeidosNotification object:nil];
    
    self.view.backgroundColor = [UIColor ALBlueColor];
    self.tableView.backgroundColor = [UIColor ALBlueColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];

    [self.tableView registerClass:[ButtonsTableViewCell class] forCellReuseIdentifier:kSocialCellIdentifier];

    self.headerView = [[HomeMenuHeaderTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320) items:[self homeItems]];

    if ([UserManager getCurrentUser]) {
        [self userLogged:nil];
    }else{
        [self userLoggedOut];
    }
}

- (void)userLogged:(NSNotification *)notification{
    self.messagesButton.userLogged = YES;
    self.myProfileButton.userLogged = YES;
}

- (void)userLoggedOut{
    self.messagesButton.userLogged = NO;
    self.myProfileButton.userLogged = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)cleanMessagesBadge:(NSNotification *)notification{
    self.messagesButton.messagesToRead = @0;
}

-(void)updateMessagesBadge:(NSNotification *)notification{
    self.messagesButton.messagesToRead = [notification object];
}

#pragma mark - HomeItems

- (NSArray*)homeItems {
    HomeMenuHeaderItem* misRutinasItem = [HomeMenuHeaderItem itemWithImageName:@"Mis_Rutinas" firstText:@"Mis" secondText:@"Rutinas"];
    misRutinasItem.target = self;
    misRutinasItem.selector = @selector(showMisRutinas);

    HomeMenuHeaderItem* misDatos = [HomeMenuHeaderItem itemWithImageName:@"Mis_Datos" firstText:@"Mis" secondText:@"Datos"];
    misDatos.target = self;
    misDatos.selector = @selector(showMisDatos);

    HomeMenuHeaderItem* seguimiento = [HomeMenuHeaderItem itemWithImageName:@"Seguimiento" firstText:@"Mi" secondText:@"Seguimiento"];
    seguimiento.target = self;
    seguimiento.selector = @selector(showSeguimiento);

    return @[misRutinasItem, misDatos, seguimiento];
}

#pragma mark - Actions

- (BOOL)mustAuthenticate:(UIViewController *)viewController{
    BOOL authenticate = NO;
    if (![viewController isKindOfClass:[ALAuthenticationViewController class]]){
        authenticate = YES;
    }
    if (!authenticate && [viewController isKindOfClass:[UINavigationController class]]) {
        for (UIViewController *child in [(UINavigationController *)viewController viewControllers]) {
            if ([child isKindOfClass:[ALAuthenticationViewController class]]) {
                authenticate = YES;
                break;
            }
        }
    }
    
    return authenticate;
}

- (void)showViewController:(UIViewController*)viewController {
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showMisRutinas {
    RutinaViewController *rutinaViewController = [[RutinaViewController alloc] initWithNibName:@"RutinaViewController" bundle:nil];
    [self showViewController:rutinaViewController];
}

- (IBAction)showMisDatos{
    MisDatosViewController* misDatosViewController = [[MisDatosViewController alloc] initWithNibName:nil bundle:nil];
    [misDatosViewController setAuthDelegate:self];
    [self showViewController:misDatosViewController];
}

- (void)showSeguimiento {
    
}

- (void)showMyLocation {
    
}

- (void)showInstitutionalSite {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.com.ar"]];
}

- (void)showFacebook {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
}

- (void)showTwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
}

- (void)showYoutube {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://youtube.com"]];
}

- (IBAction)showMessages {
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* phoneNumber = nil;
    if (buttonIndex == 1) {
        if ([alertView isEqual:self.alertSOS]) {
            phoneNumber = @"080088824324";
        }else if ([alertView isEqual:self.alertContactarAllianz]) {
            phoneNumber = @"08102222243";
        }else if ([alertView isEqual:self.alertAuxilioMecanico]) {
            phoneNumber = @"080088824324";
        }

        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
        NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Aviso" message:[NSString stringWithFormat:@"Puede llamar al %@", phoneNumber] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.headerView.frame.size.height;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell;
    if (indexPath.row < self.dataArray.count) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        cell.textLabel.font = [UIFont allianzSansLightWithSize:18];
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary* dataDictionary = self.dataArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dataDictionary[kImageName]];
        cell.textLabel.text = dataDictionary[kText];
        cell.textLabel.textColor = [UIColor whiteColor];
    }else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:kSocialCellIdentifier];
        
        UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [facebookButton setImage:[UIImage imageNamed:@"fb_icon"] forState:UIControlStateNormal];
        [facebookButton addTarget:self action:@selector(showFacebook) forControlEvents:UIControlEventTouchUpInside];
        UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [twitterButton setImage:[UIImage imageNamed:@"tw_icon"] forState:UIControlStateNormal];
        [twitterButton addTarget:self action:@selector(showTwitter) forControlEvents:UIControlEventTouchUpInside];
        UIButton *youtubeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [youtubeButton setImage:[UIImage imageNamed:@"yt_icon"] forState:UIControlStateNormal];
        [youtubeButton addTarget:self action:@selector(showYoutube) forControlEvents:UIControlEventTouchUpInside];
        [(ButtonsTableViewCell *)cell setButtons:@[facebookButton,twitterButton,youtubeButton]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor ALBlueColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dataDictionary = self.dataArray[indexPath.row];
    SEL selector = NSSelectorFromString(dataDictionary[kSelectorName]);
    SuppressPerformSelectorLeakWarning([self performSelector:selector]);
}

#pragma mark - authentication ViewController delegate
- (void)authenticationViewControllerUserLogged:(ALAuthenticationViewController *)authenticationViewController{
}

- (void)authenticationViewControllerUserNotLogged:(ALAuthenticationViewController *)authenticationViewController{
    
    self.messagesButton.userLogged = NO;
    self.messagesButton.messagesToRead = @0;
    self.myProfileButton.userLogged = NO;

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
