//
//  SDMFirstViewController.m
//  RuBeaconTest
//
//  Created by Alexey Kopchikov on 27/07/14.
//  Copyright (c) 2014 RuBeacon. All rights reserved.
//


#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT


#import "SDMFirstViewController.h"
#import "NSUUID+StaticIdentifier.h"
#import "AFNetworking.h"

@interface SDMFirstViewController ()

@property (nonatomic , weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet UIButton* nextButton;


@end

@implementation SDMFirstViewController{
    NSInteger myScore;
    NSInteger myCheckCount;
    NSMutableArray* foundedBeaconsArray;
    NSInteger level;
    BOOL levelIsFinished;
    NSMutableArray* foundNowBeacons;
    
    BOOL found0;
    BOOL found5;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    level = -1;
    
    found0 = NO;
    foundedBeaconsArray = [NSMutableArray array];
    foundNowBeacons = [NSMutableArray array];

    //[self addLoader];
    //[self nextButtonPressed:nil];
}

- (void)checkInForBeaconWithId:(NSString*)beaconId{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
 
    NSDictionary *params = @{@"uuid": [NSUUID staticUUID],
                             @"serial": beaconId};
    [manager GET:@"http://6dd21a2.ngrok.com/api/beacon/found" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void) findBeaconWithID:(NSString*) beaconID{
   //
    
    if (![foundedBeaconsArray containsObject:beaconID]) {
        int i = [beaconID intValue];
        
        
        
        if ([beaconID integerValue] - 1 != level){
            return;
        }
        
        
        
        
        level = [beaconID integerValue];
        
        switch (i) {
            case 0:
                
                [self foundedBeaconID:beaconID withScore:300];
                [self nextButtonPressed:nil];
                break;
                
            case 1:
                
                
                [self foundedBeaconID:beaconID withScore:300];
                _titleLabel.text = @"Задание 3 из 6 – найдите паб \"Нет повода не выпить\". Это любимое место телеграфистов, где они рассказывают старые байки и вспоминают теплый ламповый звук аналоговых модемов на 2400 бод. Не спрашивайте сколько это в мегабитах, берегите наших стариков... Посетителям бара фирменный коктейль \"50 телеграммов\" в подарок! И, конечно, повышенные баллы \"Большое Спасибо\". Скорее к нам!";
                break;
                
            case 2:
                [self foundedBeaconID:beaconID withScore:300];
                _titleLabel.text = @"Задание 4 из 6 – найдите ресторан авторской кухни \"Телеграфинчик\". Только здесь все настолько свежее, что Мишлен не хватило звезд, чтобы присвоить ему рейтинг. Самый лучший кофе в DI Telegraph только здесь. 26 и 27 июля для посетителей ресторана бесплатный кофе.";
                break;
                
            case 3:
                [self foundedBeaconID:beaconID withScore:300];
                _titleLabel.text = @"Задание 5 из 6 – найдите отделение \"Грефбанка\" - самого надежного банка по мнению его клиентов. Менеджеры банка с улыбкой помогут решить все ваши финансовые задачи, которые конкуренты называют \"проблемами\". \"Грефбанк\" любит зелень – только этим летом льготные потребительские кредиты. Позвольте себе отдохнуть!";
                break;
                
            case 4:
                [self foundedBeaconID:beaconID withScore:300];
                _titleLabel.text = @"Задание 6 из 6 (вы почти у цели! – Найдите магазин продуктов \"Пусть всегда будет ветер\" в нем настолько свежая еда, что перед тем как ее купить вам надо будет ее сорвать или догнать!";
                break;
                
            case 5:
                [self foundedBeaconID:beaconID withScore:300];
                _titleLabel.text = @"Хорошо, что вы пришли!";
                
                
                [self nextButtonPressed:nil];
                break;

        }
        
        
    }
}

- (IBAction)nextButtonPressed:(id)sender{
    if (foundedBeaconsArray.count > 5) {
        _titleLabel.text= @"Квест завершен! Скорее посетите виртуальное представительство \"Сбербанк\" в коворкинге DI Telegraph и зафиксируйте свои результаты. Поздравляем!";
        return;
    }
    
        switch (level) {
         
            case -1:
                //level = 1;
                _titleLabel.text= @"Задание 1 из 6 Открытие счета и получение карточки Посетите наше \"представительство\" офиса Сбербанка, где вам мгновенно откроют для целей нашего квеста игровой счет и выдадут игровую карту. Представительство находится по адресу: Коворкинг DI Telegraph, слева от входа (алый стол) Приложение выдаст вам оповещение о том, что вы успешно нашли \"представительство\"";
                found0 = YES;
                [_nextButton setHidden:YES];
                [self addLoader];
                break;
            case 0:
                //
                _titleLabel.text= @"Задание 2 из 6 – найдите отель \"Телеграфные Столбы\". Перед сном считайте только наши столбы! Гостям отеля мы предлагаем свободные номера со скидкой 50%, а также баллы \"Большое Спасибо\". Заходите, будем рады!";

                [_nextButton setHidden:YES];
                [self addLoader];
                break;
                
            default:
                _titleLabel.text= [NSString stringWithFormat:@"Задание %ld из 6 \nПродолжаем искать!", foundedBeaconsArray.count + 1];
                break;
        }
}



- (void) foundedBeaconID:(NSString*) bid withScore:(NSInteger) score{
    
    if (![foundedBeaconsArray containsObject:bid]) {
        
        [self checkInForBeaconWithId:bid];
        
        myCheckCount = myCheckCount + 1;
        myScore = myScore + score;
        [foundedBeaconsArray addObject:bid];
        
        NSString* message = [NSString stringWithFormat:@"Поздравляем! Вы выполнили %ld задание из 6  Вам начислено %ld больших Спасибо!  Баланс: %ld", foundedBeaconsArray.count,  (long)score ,(long) myScore];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"УРА!" otherButtonTitles: nil];
        [alert show];
        
    }
}

- (void) addLoader{
    UIActivityIndicatorView *spinning = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinning.frame = CGRectMake(140, 420, 37, 37);
    
    [self.view addSubview:spinning];
    [spinning startAnimating];
}

@end
