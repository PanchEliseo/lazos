//
//  AMPopTip+Draw.h
//  AMPopTip
//

#import "AMPopTip.h"

@interface AMPopTip (Draw)

/** Poptip's Bezier path
 *
 * Returns the path used to draw the poptip, used internally by the poptip.
 *
 * @param rect The rect holding the poptip
 * @param direction The direction of the poptip appearance
 * @return UIBezierPath The poptip's path
 */
- (UIBezierPath *)pathWithRect:(CGRect)rect direction:(AMPopTipDirection)direction;

@end
