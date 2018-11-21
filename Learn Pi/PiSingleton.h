//
//  PiScore.h
//  Learn Pi Free
//
//  Created by John Dugan on 2/10/15.
//
//

#import <Foundation/Foundation.h>

@interface PiSingleton : NSObject

@property (nonatomic, retain) NSMutableArray *highScores;
@property (nonatomic, retain) NSNumber *highestScore;

@property (nonatomic) BOOL practiceMode;

@property (nonatomic) BOOL altLayout;
@property (nonatomic) BOOL soundOn;
@property (nonatomic) BOOL strikesOff;
@property (nonatomic) BOOL digitInput;

+(NSString *)piString:(BOOL)includePrefix;
+(instancetype)sharedPiScore;
-(NSInteger)checkLegacyScore;

-(void)save;

@end
