#include "stm32f401xe.h"

void SET_GPIO_PINS(){
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;

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
	int config[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111, 119, 124, 57, 94, 121, 113};
	int value;
	int lowPart;
	SET_GPIO_PINS();
	
	while(1){
		value = GPIOC->IDR;
		lowPart = 0x0000000F & value;
		GPIOB->ODR = config[lowPart];
	}
}
