//
//  LanguageSupport.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 05.05.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

#if swift(>=4.2)
    let CollectionSectionHeaderType = UICollectionView.elementKindSectionHeader
#else
    let CollectionSectionHeaderType = UICollectionElementKindSectionHeader
#endif

#if swift(>=4.2)
    let CollectionSectionFooterType = UICollectionView.elementKindSectionFooter
#else
    let CollectionSectionFooterType = UICollectionElementKindSectionFooter
#endif
