/*
 * block.m
 * libblock
 *
 * Created by Árpád Goretity on 24/01/2012.
 * Released into the public domain
*/

#include <objc/runtime.h>
#include <block.h>

@implementation __lb_block

/*
 * self, super
*/

- (id) init
{
	if ((self = [super init]))
	{
		__desc = malloc(sizeof(*__desc));
		__desc->__res = 0;
		__desc->__size = class_getInstanceSize([self class]);
		__desc->__copy = NULL;
		__desc->__dispose = NULL;
		__flags = 0;
	}
	return self;
}

- (void) dealloc
{
	free(__desc);
	[super dealloc];
}

/*
 * NSCopying
*/
- (id) copyWithZone:(NSZone *)zone
{
	__lb_block *copy = [[[self class] allocWithZone:zone] init];
	copy->__invoke = __invoke;
	return copy;
}

@end

