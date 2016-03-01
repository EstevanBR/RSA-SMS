//
//  rsac.h
//  rsasms
//
//  Created by Estevan Hernandez on 3/1/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#ifndef rsac_h
#define rsac_h

void encryptToFile (char const *textToProcess, unsigned long const p, unsigned long const q, const char *fileName);
void decryptFromFileToFile(unsigned long const p, unsigned long const q, const char *fileName, const char *fileNameDest);
unsigned long modpow(unsigned long base,unsigned long exponent,unsigned long modulus);
void clear(void);
unsigned long modInverse (unsigned long, unsigned long);
unsigned long gcd (unsigned long, unsigned long);
unsigned long gcdExtended (unsigned long, unsigned long, unsigned long*, unsigned long*);
char *inputString (FILE* fp, size_t size, char terminatingCharacter);
unsigned long getUnsignedLongFromStream(FILE *fp);
int validateN(unsigned long n);

#endif /* rsac_h */
