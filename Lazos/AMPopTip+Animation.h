//
//  AMPopTip+Animation.h
//  AMPopTip
//

#import "AMPopTip.h"

@interface AMPopTip (Animation)

/** Start the popover action animation
 *
 * Starts the popover action animation. Does nothing if the popover wasn't animating in the first place.
 */
- (void)performActionAnimation;

/** Stops the popover action animation
 *
 * Stops the popover action animation. Does nothing if the popover wasn't animating in the first place.
 */
- (void)dismissActionAnimation;

@end
