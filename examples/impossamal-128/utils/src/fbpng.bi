#ifndef _PNG_LOAD_BI_
#define _PNG_LOAD_BI_

#ifndef PNG_STATICZ
#inclib "fbpng"
#inclib "z"
#else
#inclib "fbpngs"
#endif

#ifdef PNG_DEBUG
#include once "fbmld.bi"
#endif

enum png_target_e
	PNG_TARGET_BAD
	PNG_TARGET_FBOLD
	PNG_TARGET_FBNEW
	PNG_TARGET_OPENGL
#if __FB_MIN_VERSION__( 0, 17, 0 )
        PNG_TARGET_DEFAULT = PNG_TARGET_FBNEW
#else
	PNG_TARGET_DEFAULT = PNG_TARGET_FBOLD
#endif
end enum

declare function png_load cdecl alias "png_load" _
	( _
		byref filename as string, _
		byval target   as png_target_e = PNG_TARGET_DEFAULT _
	) as any ptr

declare function png_load_mem cdecl alias "png_load_mem" _
	( _
		byval buffer     as any ptr, _
		byval buffer_len as integer, _
		byval target     as png_target_e = PNG_TARGET_DEFAULT _
	) as any ptr

declare function png_save cdecl alias "png_save" _
	( _
		byref filename as string, _
		byval img      as any ptr _
	) as integer

declare sub png_destroy cdecl alias "png_destroy" _
	( _
		byval buffer as any ptr _
	)

declare sub png_dimensions cdecl alias "png_dimensions" _
	( _
		byref filename as string, _
		byref w        as uinteger, _
		byref h        as uinteger _
	)

declare sub png_dimensions_mem cdecl alias "png_dimensions_mem" _
	( _
		byval buffer as any ptr, _
		byref w      as uinteger, _
		byref h      as uinteger _
	)

#endif '_PNG_LOAD_BI_
