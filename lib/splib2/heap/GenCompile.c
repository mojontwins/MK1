
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char **argv)
{
   char *ptr;
   char buff[256];
   char command[512];
   FILE *in;

   if (argc < 3) {
      fprintf(stderr, "Usage: %s BaseCommandString FileWithList\n", argv[0]);
      exit(1);
   }

   if ((in = fopen(argv[2],"r")) == NULL) {
      fprintf(stderr, "%s: Couldn't open \"%s\"\n", argv[0], argv[2]);
      exit(2);
   }

   while (!feof(in)) {
      fgets(buff,256,in);
	for (ptr=buff; (*ptr!='\0') && (!isspace(*ptr)); ptr++);
	*ptr='\0';
	printf("\nFILE = \"%s\"\n\n", buff);
	if (*buff != '\0') {
         sprintf(command,"%s %s",argv[1],buff);
         system(command);
      }
   }

   fclose(in);
   return 0;
}

