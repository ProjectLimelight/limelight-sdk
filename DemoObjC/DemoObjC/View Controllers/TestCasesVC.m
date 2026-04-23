//
//  TestCasesVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "TestCasesVC.h"
#import "TestCase.h"

// MARK: - Private Interface

@interface TestCasesVC ()

@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TestCase *> *> *testCases;

@end

// MARK: - Implementation

@implementation TestCasesVC

// MARK: - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testCases = [TestCase testCases];
    [self.tableView reloadData];
    self.tableView.sectionHeaderTopPadding = 32;
}

// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.testCases.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionKey = [TestCase sectionKeyOfIndex:section];
    if (!sectionKey) { return 0; }
    return self.testCases[sectionKey].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSString *sectionKey = [TestCase sectionKeyOfIndex:indexPath.section];
    if (!sectionKey) { return cell; }
    NSArray<TestCase *> *section = self.testCases[sectionKey];
    if (!section) { return cell; }
    cell.textLabel.text = section[indexPath.row].title;
    return cell;
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *sectionKey = [TestCase sectionKeyOfIndex:indexPath.section];
    if (!sectionKey) { return; }
    NSArray<TestCase *> *section = self.testCases[sectionKey];
    if (!section) { return; }

    // Create and configure UIViewController for testCase
    UIViewController *vc = [section[indexPath.row] makeViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [TestCase sectionKeyOfIndex:section];
}

@end
