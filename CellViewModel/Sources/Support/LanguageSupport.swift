//
//  LanguageSupport.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 05.05.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

#if swift(>=4.2)
    let collectionSectionHeaderType = UICollectionView.elementKindSectionHeader
#else
    let collectionSectionHeaderType = UICollectionElementKindSectionHeader
#endif

#if swift(>=4.2)
    let collectionSectionFooterType = UICollectionView.elementKindSectionFooter
#else
    let collectionSectionFooterType = UICollectionElementKindSectionFooter
#endif
