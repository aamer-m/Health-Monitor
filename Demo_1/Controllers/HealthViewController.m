//
//  HealthViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 11/4/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "HealthViewController.h"
#import "Charts/Charts-swift.h"
#import "Helper.h"
#import "LogoutObject.h"

@interface HealthViewController () <ChartViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;

@property (weak, nonatomic) IBOutlet UILabel *pulseCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSNumber *limit;
@property (strong, nonatomic) NSNumber *lowerLimit;
@property (strong, nonatomic) NSNumber *higherLimit;
@property (strong, nonatomic) NSMutableArray *dates;
@property (strong, nonatomic) NSMutableArray *weights;
@property (strong, nonatomic) NSDateFormatter *chartDateFormatter;
@property (strong, nonatomic) NSDateFormatter *listDateFormatter;
@property (strong, nonatomic) NSMutableDictionary *mDictionary;
@end

@implementation HealthViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LogoutObject addLogoutIconInViewController:self];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addWeightValue)];
    NSMutableArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    [rightBarButtonItems addObject:addButton];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    self.lineChartView.delegate = self;
    
    self.lineChartView.descriptionText = @"";
    self.lineChartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    self.lineChartView.dragEnabled = YES;
    [self.lineChartView setScaleEnabled:YES];
    self.lineChartView.pinchZoomEnabled = YES;
    self.lineChartView.drawGridBackgroundEnabled = NO;
    
    self.limit = @5.0f;
    self.lowerLimit = @60.0f;
    self.higherLimit = @100.0f;
    
    // x-axis limit line
    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:self.limit.floatValue label:@"Index 5"];
    llXAxis.lineWidth = 4.0;
    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
    llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
    //[self.lineChartView.xAxis addLimitLine:llXAxis];
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:self.higherLimit.floatValue
                                                          label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:self.lowerLimit.floatValue
                                                          label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.lineDashLengths = @[@5.f, @5.f];
    ll2.labelPosition = ChartLimitLabelPositionRightBottom;
    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    [leftAxis addLimitLine:ll2];
    leftAxis.customAxisMax = 120.0;
    leftAxis.customAxisMin = 40.0;
    leftAxis.startAtZeroEnabled = NO;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    self.lineChartView.rightAxis.enabled = NO;
    
    [self.lineChartView.viewPortHandler setMaximumScaleY: 2.f];
    [self.lineChartView.viewPortHandler setMaximumScaleX: 2.f];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
//    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:1.0] font:[UIFont systemFontOfSize:12.0] insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    self.lineChartView.marker = marker;
//    
//    self.lineChartView.legend.form = ChartLegendFormLine;
//    
//    _sliderX.value = 44.0;
//    _sliderY.value = 100.0;
//    [self slidersValueChanged:nil];
    
    [self.lineChartView animateWithXAxisDuration:2.5 easingOption:ChartEasingOptionEaseInOutQuart];
    
    
    self.listDateFormatter = [[NSDateFormatter alloc] init];
    [self.listDateFormatter setDateFormat:@"dd MMM, YY"];
    
    self.chartDateFormatter = [[NSDateFormatter alloc] init];
    [self.chartDateFormatter setDateFormat:@"MMM,dd-YY"];
    
    self.dates = [@[] mutableCopy];
    
    NSDate *date = [NSDate date];
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    NSDate* dateOnly = [calendar dateFromComponents:components];
    for (NSUInteger i =0 ; i < 12; ++i) {
        
        
        [self.dates addObject:dateOnly];
        dateOnly = [dateOnly dateByAddingTimeInterval:-30*60*60*24];
    }
    self.weights = [@[@"65", @"68", @"65", @"70", @"71", @"68", @"70", @"67", @"65", @"68", @"65", @"73"] mutableCopy];
    [self.dates sortUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [obj1 compare:obj2] == NSOrderedDescending;
    }];
    self.mDictionary = [NSMutableDictionary dictionaryWithObjects:self.weights forKeys:self.dates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setDataCount:(unsigned int)self.dates.count range:50.0f];
}

- (void)addWeightValue {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Weight" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Type weight here";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
        NSDate* dateOnly = [calendar dateFromComponents:components];
        [self.mDictionary setObject:textField.text forKey:dateOnly];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    alertController.preferredAction = okAction;
    
    [self presentViewController:alertController animated:FALSE completion:nil];
    
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    int i = 0;
    NSArray *datesArray = [self datesArrayInAscending:NO];
    for (NSDate *date in datesArray)
    {

        [xVals addObject:[self.chartDateFormatter stringFromDate:date]];
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:((NSString *)self.mDictionary[date]).doubleValue xIndex:i]];
        i++;
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"Weight Changes"];
    
    set1.lineDashLengths = @[@5.f, @2.5f];
    set1.highlightLineDashLengths = @[@5.f, @2.5f];
    [set1 setColor:UIColor.blackColor];
    [set1 setCircleColor:UIColor.blackColor];
    set1.lineWidth = 1.0;
    set1.circleRadius = 3.0;
    set1.drawCircleHoleEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:9.f];
    set1.fillAlpha = 65/255.0;
    set1.fillColor = UIColor.blackColor;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    
    self.lineChartView.data = data;
}
- (IBAction)changeType:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.tableView.hidden = true;
        self.lineChartView.hidden = false;
        [self setDataCount:(unsigned int)self.dates.count range:100.0f];
    } else {
        self.lineChartView.hidden = true;
        self.tableView.hidden = false;
        [self.tableView reloadData];
    }
}

- (NSArray *)datesArrayInAscending:(BOOL)selection {
    NSMutableArray *datesArray = [[self.mDictionary allKeys] mutableCopy];
    [datesArray sortUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [obj1 compare:obj2] == (selection ? NSOrderedAscending :NSOrderedDescending);
    }];
    return datesArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mDictionary.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSArray *datesArray = [self datesArrayInAscending:YES];
    cell.textLabel.text = self.mDictionary[datesArray[indexPath.row]];
    cell.detailTextLabel.text = [self.listDateFormatter stringFromDate:datesArray[indexPath.row]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
