//
//  SupressFunction.h
//  AllianzMisAsegurados
//
//  Created by Matías Ginart on 9/30/14.
//  Copyright (c) 2014 RedBee. All rights reserved.
//

#ifndef AllianzMisAsegurados_SupressFunction_h

#define AllianzMisAsegurados_SupressFunction_h

#define SuppressPerformSelectorLeakWarning(Stuff) \
	do { \
		_Pragma("clang diagnostic push") \
		_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
		Stuff; \
		_Pragma("clang diagnostic pop") \
	} while (0)


#endif
