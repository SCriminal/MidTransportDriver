//
//  Header.h
//
//

#ifndef wns_Header_h
#define wns_Header_h



//结构体
struct STRUCT_XY {
    CGFloat horizonX;
    CGFloat verticalY;
};
typedef struct STRUCT_XY STRUCT_XY;
CG_INLINE STRUCT_XY
XY(CGFloat horizonX, CGFloat verticalY)
{
    STRUCT_XY size; size.horizonX = horizonX; size.verticalY = verticalY; return size;
}


#endif


