//
//  AMPopTip+Entrance.h
//  AMPopTip
//

#import "AMPopTip.h"

@interface AMPopTip (Entrance)

/** Perform entrance animation
 *
 * Triggers the chosen entrance animation
 *
 * @param completion Completion handler
 */
- (void)performEntranceAnimation:(void (^)())completion;

@end
