#include "stm32f401xe.h"

void SET_GPIO_PINS(){
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;

	// A GROUP
	// SET OUTPUT PINS OF B GROUP
	// FIRST SEVEN SEGMENT
	GPIOA->MODER = 0x00000000;
	GPIOA->MODER |= (1UL << 2*0);
	GPIOA->MODER |= (1UL << 2*1);
	GPIOA->MODER |= (1UL << 2*2);
	GPIOA->MODER |= (1UL << 2*3);
	GPIOA->MODER |= (1UL << 2*4);
	GPIOA->MODER |= (1UL << 2*5);
	GPIOA->MODER |= (1UL << 2*6);

	GPIOA->PUPDR  = 0x00000000;
	GPIOA->OTYPER = 0x00000000;

	
	// B GROUP
	// SET OUTPUT PINS OF B GROUP
	// FIRST SEVEN SEGMENT
	GPIOB->MODER = 0x00000000;
	GPIOB->MODER |= (1UL << 2*0);
	GPIOB->MODER |= (1UL << 2*1);
	GPIOB->MODER |= (1UL << 2*2);
	GPIOB->MODER |= (1UL << 2*3);
	GPIOB->MODER |= (1UL << 2*4);
	GPIOB->MODER |= (1UL << 2*5);
	GPIOB->MODER |= (1UL << 2*6);

	GPIOB->PUPDR  = 0x00000000;
	GPIOB->OTYPER = 0x00000000;

	// C GROUP
	// SET INPUT PINS OF C GROUP
	GPIOC->MODER  = 0x00000000;
	// SET DEFUALT VALUE INPUT OF C GROUP
	// FIRST DIPSWITCH
	GPIOC->PUPDR  = 0x00000000;
	GPIOC->PUPDR |= (2UL << 2*0);
	GPIOC->PUPDR |= (2UL << 2*1);
	GPIOC->PUPDR |= (2UL << 2*2);
	GPIOC->PUPDR |= (2UL << 2*3);

}

int main(){
	
	int counter = 0;
	
	int config[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111, 119, 124, 57, 94, 121, 113};
	int value;
	int fib[] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89};

	SET_GPIO_PINS();
	
	while(1){
		value = 0x00000003 & GPIOC->IDR;
		if(value == 2 | value == 1){
			if(value == 1)
				counter += 1;
			if(value == 2)
				counter -= 1;
		}
	  GPIOB->ODR = config[fib[counter]%10];
		GPIOA->ODR = config[fib[counter]/10];
		
		for(int i=0; i<300000; i++); //delay
		
	}
}
