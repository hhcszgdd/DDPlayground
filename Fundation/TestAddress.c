//
//  TestAddress.c
//  MyPlayground
//
//  Created by JohnConnor on 2020/6/14.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#include "TestAddress.h"

void printSomething(){
    int intValue = 33;
    int * i = &intValue;
    printf("xxxx:%p \n", i);//address
    printf("xxxx:%d \n", *i);//value
}
