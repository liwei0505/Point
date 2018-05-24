//
//  SortHelper.cpp
//  foundation
//
//  Created by lee on 2018/5/24.
//  Copyright © 2018年 lee. All rights reserved.
//

#include "SortHelper.hpp"
#include <iostream>
#include <ctime>
#include <cassert>

using namespace std;
namespace SortHelper {
    //生成n个随机数，范围为[rangeL,rangeR]
    int * generateRandomArray(int n, int rangeL, int rangeR) {
        assert( rangeL <= rangeR);
        int *arr = new int[n];
        srand(time(NULL));
        for (int i=0; i<n; i++) {
            arr[i] = rand() % (rangeR - rangeL + 1) + rangeL;
            cout << arr[i];
        }
        return arr;
    }
}
