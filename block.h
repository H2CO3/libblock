/*
 * block.h
 * libblock
 *
 * Created by Árpád Goretity on 24/01/2012.
 * Released into the public domain
*/
 
#ifndef __BLOCK_H__
#define __BLOCK_H__

#include <stdarg.h>
#include <Foundation/Foundation.h>

typedef struct
{
	unsigned long int	__res;
	unsigned long int	__size;
	void			(*__copy)(void *dst, void *src);
	void			(*__dispose)(void *);
}  __lb_desc;

@interface __lb_block: NSObject <NSCopying>
{
	@private
	int		__flags;
	int		__reserved;
	@public
	void		*(*__invoke)(void *__self, ...);
	@private
	__lb_desc	*__desc;
}

@end

#define BLOCK(__lb_block_code) \
({ \
	void *__lb_block_func(void *__self, ...) \
	{ \
		va_list __va_args; \
		va_start(__va_args, __self); \
		__lb_block_code; \
		va_end(__va_args); \
		return NULL; \
	} \
	__lb_block *__lb_block_obj = [[[__lb_block alloc] init] autorelease]; \
	__lb_block_obj->__invoke = __lb_block_func; \
	__lb_block_obj; \
})

#define BEXEC(__lb_block_self, ...) (((__lb_block *)__lb_block_self)->__invoke(__lb_block_self , ## __VA_ARGS__))

#endif /* __BLOCK_H__ */

