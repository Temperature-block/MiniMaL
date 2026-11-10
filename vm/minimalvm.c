#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define cell uint32_t

cell c;

enum cinsn {
LDC,
EXTENDENV
};

struct stack
{
 uint32_t val;
 struct stack* next;
 struct stack* prev;
};

struct stack* push(struct stack *top, cell val)
{

 struct stack* newtop = (struct stack *) malloc(sizeof(struct stack));

 if (newtop != NULL) {
    if(top != NULL){
      top->next = newtop;
    }
    newtop->val = val;
    newtop->next = NULL;
    newtop->prev = top;
    return newtop;
 }

}

cell pop(struct stack *top) {
     (top->prev)->next = NULL;
     cell x = top->val;
     free(top);
     return x;
}

void exec(struct stack* s,struct stack *e){

   while(1){

     cell insn = fetch (c);
     enum cinsn clas = classify_insn(insn);
     if(clas == LDC){
        cell val = fetch (c+1);
        s = push(s,val);
        c = c + 2;
      }

     else if(clas == EXTENDENV){
        struct stack* tmp = s->prev;
        cell val = pop(s);
        s = tmp;
        d = push(e,val);
        c = c + 1;
     }

    }
}


int main(int argc,char* argv[]){

 if (argc < 2) {
   fprintf(stderr, "Error: %s", "Expected more than 0 args");
   return 1;
 }

   return interpret(argv[1]);
}
