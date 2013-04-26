//
//  ANHCellStateChangedDelegate.h
//  Reversi
//
//  Cell state delegate will notify GameCellView if a cell data changed
//
//  Created by Anh Nguyen on 3/9/13.
//  Copyright (c) 2013 Anh Nguyen. All rights reserved.
//

#ifndef Reversi_ANHCellStateChangedDelegate_h
#define Reversi_ANHCellStateChangedDelegate_h


@protocol CellStateDelegate <NSObject>

- (void) cellChanged:(BOOL) flip;

@end

#endif
