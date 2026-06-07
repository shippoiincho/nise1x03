// Nise 1x03
// MZ-1X03 Emulator

// Pin connections
// PC0: SW1
// PC1: SW2
// PC4: JA1
// PC5: JA2
// PD0: VBLNK
// PD3: JOY X
// PD4: JOY Y

//#define DEBUG

#include "debug.h"

// Initialize

void initgpio(void) {

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD | RCC_APB2Periph_GPIOC, ENABLE);


    GPIO_InitTypeDef  GPIO_InitStructure = {0};

    // PC0 & 1 for input with pull up

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(GPIOC, &GPIO_InitStructure);

    // PC4 & 5 for output

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4 | GPIO_Pin_5;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(GPIOC, &GPIO_InitStructure);

    // PD0 for input

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 ;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(GPIOD, &GPIO_InitStructure);

    // PD3 & 4 for ADC ch 4/5

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3 | GPIO_Pin_4;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;
    GPIO_Init(GPIOD, &GPIO_InitStructure);

}

void initadc(void) {

    ADC_InitTypeDef  ADC_InitStructure = {0};

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1, ENABLE);
    RCC_ADCCLKConfig(RCC_PCLK2_Div8);

    ADC_DeInit(ADC1);
    ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
    ADC_InitStructure.ADC_ScanConvMode = DISABLE;
    ADC_InitStructure.ADC_ContinuousConvMode = DISABLE;
    ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
    ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
    ADC_InitStructure.ADC_NbrOfChannel = 1;
    ADC_Init(ADC1, &ADC_InitStructure);

    ADC_Calibration_Vol(ADC1, ADC_CALVOL_50PERCENT);
    ADC_Cmd(ADC1, ENABLE);

    ADC_ResetCalibration(ADC1);
    while(ADC_GetResetCalibrationStatus(ADC1));
    ADC_StartCalibration(ADC1);
    while(ADC_GetCalibrationStatus(ADC1));


}

uint16_t getadc(uint8_t ch)
{
    uint16_t val;

    ADC_RegularChannelConfig(ADC1, ch, 1, ADC_SampleTime_241Cycles);
    ADC_SoftwareStartConvCmd(ADC1, ENABLE);

    while(!ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC));
    val = ADC_GetConversionValue(ADC1);

    return val;
}

int main(void)
{
    uint16_t adc_x,adc_y,sws;
    uint32_t time_x,time_y;

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
    SystemCoreClockUpdate();
    Delay_Init();

    // DEBUG

//#ifdef DEBUG
//
//    SDI_Printf_Enable();
//
//    printf("SystemClk:%d\r\n",SystemCoreClock);
//    printf( "ChipID:%08x\r\n", DBGMCU_GetCHIPID() );
//
//#endif

 // Initialize GPIOs

    initgpio();
    initadc();

//#ifdef DEBUG
//
//    while(1) {
//
//        adc_x=getadc(ADC_Channel_4);
//
//        Delay_Us(1);
//
//        adc_y=getadc(ADC_Channel_7);
//
//        sws=GPIO_ReadInputData(GPIOC);
//
//        printf("%x %x %x\n\r",adc_x,adc_y,sws);
//
//        Delay_Ms(1000);
//
//    }
//
//
//
//#endif

    // Joystick initial value

    adc_x=getadc(ADC_Channel_4);
    adc_y=getadc(ADC_Channel_7);

    time_x= adc_x * 78 / 40 ;
    time_y= adc_y * 78 / 40 ;

    while(1)
    {

        // WAIT  VBLNK to Low

        while(GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_0)==Bit_SET) ;

        GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_RESET);
        GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_RESET);

        // WAIT 280cycles = 78usec
        Delay_Us(78);

//        GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_SET);
//        GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_SET);

        // WAIT

        if(adc_y>=adc_x) {

            Delay_Us(time_x);
            GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_SET);

            Delay_Us(time_y-time_x);
            GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_SET);

        } else {

            Delay_Us(time_y);
            GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_SET);

            Delay_Us(time_x-time_y);
            GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_SET);

        }

        // WAIT  VBLNK to High

        while(GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_0)==Bit_RESET) ;

        // send BUTTON Status

        sws=GPIO_ReadInputData(GPIOC);

        if(sws&1) {
            GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_SET);
        } else {
            GPIO_WriteBit(GPIOC, GPIO_Pin_4, Bit_RESET);
        }

        if(sws&2) {
            GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_SET);
        } else {
            GPIO_WriteBit(GPIOC, GPIO_Pin_5, Bit_RESET);
        }

        // ADC MAX value = 4095
        // MAX Count value= 2000
        // factor = 4095/2000 = 2

        adc_x=getadc(ADC_Channel_4);
        adc_y=getadc(ADC_Channel_7);

        time_x= adc_x * 78 / 40 ;
        time_y= adc_y * 78 / 40 ;

    }
}
