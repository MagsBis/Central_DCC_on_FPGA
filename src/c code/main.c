#include "my_top_dcc.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xgpio.h"

// MARCHE AVANT ON
#define S0  0x60//01100000 //Stop
#define S1  0x70//01110000 //Stop immediat
#define S2  0x61//01100001 //E-stop
#define S3  0x71//01110001 // E-stop immediat

#define S4  0x62//01100010 //Step 1
#define S5  0x72//01110010 //Step 2
#define S6  0x63//01100011 //Step 3
#define S7  0x73//01110011 //Step 4
#define S8  0x64//01100100 //Step 5
#define S9  0x74//01110100 //Step 6
#define S10 0x65//01100101 //Step 7
#define S11 0x75//01110101 //Step 8
#define S12 0x66//01100110 //Step 9
#define S13 0x76//01110110 //Step 10
#define S14 0x67//01100111 //Step 11
#define S15 0x77//01110111 //Step 12
#define S16 0x68//01101000 //Step 13
#define S17 0x78//01111000 //Step 14
#define S18 0x69//01101001 //Step 15
#define S19 0x79//01111001 //Step 16
#define S20 0x6A//01101010 //Step 17
#define S21 0x7A//01111010 //Step 18
#define S22 0x6B//01101011 //Step 19
#define S23 0x7C//01111011 //Step 20
#define S24 0x6C//01101100 //Step 21
#define S25 0x7C//01111100 //Step 22
#define S26 0x6D//01101101 //Step 23
#define S27 0x7D//01111101 //Step 24
#define S28 0x6E//01101110 //Step 25
#define S29 0x7E//01111110 //Step 26
#define S30 0x6F//01101111 //Step 27
#define S31 0x7F//01111111 //Step 28

//---------------------------------------------------------------------------------------------/

// MARCHE ARRIERE ON
#define R0  0x40//01000000 //Stop
#define R1  0x50//01010000 //Stop immediat
#define R2  0x41//01000001 //E-stop
#define R3  0x51//01010001 // E-stop immediat
#define R4  0x42//01000010 //Step 1
#define R5  0x52//01010010 //Step 2
#define R6  0x43//01000011 //Step 3
#define R7  0x53//01010011 //Step 4
#define R8  0x44//01000100 //Step 5
#define R9  0x54//01010100 //Step 6
#define R10 0x45//01000101 //Step 7
#define R11 0x55//01010101 //Step 8
#define R12 0x46//01000110 //Step 9
#define R13 0x56//01010110 //Step 10
#define R14 0x47//01000111 //Step 11
#define R15 0x57//01010111 //Step 12
#define R16 0x48//01001000 //Step 13
#define R17 0x58//01011000 //Step 14
#define R18 0x49//01001001 //Step 15
#define R19 0x59//01011001 //Step 16
#define R20 0x4A//01001010 //Step 17
#define R21 0x5A//01011010 //Step 18
#define R22 0x4B//01001011 //Step 19
#define R23 0x5B//01011011 //Step 20
#define R24 0x4C//01001100 //Step 21
#define R25 0x5C//01011100 //Step 22
#define R26 0x4D//01001101 //Step 23
#define R27 0x5D//01011101 //Step 24
#define R28 0x4E//01001110 //Step 25
#define R29 0x5E//01011110 //Step 26
#define R30 0x4F//01001111 //Step 27
#define R31 0x5F//01011111 //Step 28

//---------------------------------------------------------------------------------------------/

//FONCTIONS ON
#define F0  0x90   //10010000         //Lumiere ON
#define F1  0x81   //10000001         //Son
#define F2  0x82   //10000010         //Cor Francais 1
#define F3  0x84   //10000100         //Cor Francais 2
#define F4  0x88   //10001000         //Turbo off
#define F5  0xB1   //10110001         //Compresseur
#define F6  0xB2   //10110010         //Acceleration/freinage temps, bouchant mode/ vitesse de manoeuvre
#define F7  0xB4   //10110100         //Courbe grincement
#define F8  0xB8   //10111000         //Ferroviaire Clank
#define F9  0xA1   //10100001         //Ventilateur
#define F10 0xA2   //10100010         //Conducteur de signal
#define F11 0xA4   //10100100         //Court Cor Francais 1
#define F12 0xA8   //10101000         //Court Cor Francais 2
#define F13 0xDE01 //11011110 00000001 //L'annonce station francaise 1
#define F14 0xDE02 //11011110 00000010 //L'annonce station francaise 2
#define F15 0xDE04 //11011110 00000100 //Signal francaise 1
#define F16 0xDE08 //11011110 00001000 //Signal francaise 2
#define F17 0xDE10 //11011110 00010000 //Port chauffeur ouvrir/fermer
#define F18 0xDE20 //11011110 00100000 //Valve
#define F19 0xDE40 //11011110 01000000 //Attelage
#define F20 0xDE80 //11011110 10000000 //Sable

//FONCTIONS OFF
#define F0_OFF  0x10   //100 10000         //Lumiere ON
#define F1_OFF  0x1   //100 00001         //Son
#define F2_OFF  0x2   //100 00010         //Cor Francais 1
#define F3_OFF  0x4   //100 00100         //Cor Francais 2
#define F4_OFF  0x8   //100 01000         //Turbo off

#define F5_OFF  0x11   //101 10001         //Compresseur
#define F6_OFF  0x12   //101 10010         //Acceleration/freinage temps, bouchant mode/ vitesse de manoeuvre
#define F7_OFF  0x14   //101 10100         //Courbe grincement
#define F8_OFF  0x18  //101 11000         //Ferroviaire Clank
#define F9_OFF  0x1   //101 00001         //Ventilateur
#define F10_OFF 0x2   //101 00010         //Conducteur de signal
#define F11_OFF 0x4   //101 00100         //Court Cor Francais 1
#define F12_OFF 0x8   //101 01000         //Court Cor Francais 2

#define F13_OFF 0x1    //11011110 00000001 //L'annonce station francaise 1
#define F14_OFF 0x2    //11011110 00000010 //L'annonce station francaise 2
#define F15_OFF 0x4    //11011110 00000100 //Signal francaise 1
#define F16_OFF 0x8    //11011110 00001000 //Signal francaise 2
#define F17_OFF 010    //11011110 00010000 //Port chauffeur ouvrir/fermer
#define F18_OFF 0x20   //11011110 00100000 //Valve
#define F19_OFF 0x40   //11011110 01000000 //Attelage
#define F20_OFF 0x80   //11011110 10000000 //Sable

//--------------------------------------------------------------------------------------------/

//tableau vitesse marche avant ACTIVATION
unsigned int vitesse_av[32] = { S0 , S1 ,S2,  S3 , S4 , S5 , S6 , S7 ,  S8 , S9 , S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, S30, S31};

//tableau vitesse marche arriere ACTIVATION
unsigned int vitesse_ar[32] = { R0 , R1 , R2 , R3 , R4 , R5 , R6, R7 ,  R8 , R9 , R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31};

//tableau fonctions ACTIVATION
unsigned int fonctions[20] = { F0 , F1 , F2, F3 , F4 , F5 , F6 , F7 ,  F8 , F9 , F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20};
//tableau fonctions DESACTIVATION
unsigned int fonctions_OFF[20] = { F0_OFF , F1_OFF , F2_OFF, F3_OFF, F4_OFF , F5_OFF , F6_OFF , F7_OFF ,  F8_OFF , F9_OFF , F10_OFF, F11_OFF, F12_OFF, F13_OFF, F14_OFF, F15_OFF, F16_OFF, F17_OFF, F18_OFF, F19_OFF, F20_OFF};

//tableau correspondant aux vitesses marche avant configurees, si S0 est activee alors case 0 est a 1
unsigned int fonctions_actif[20] = {0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0 , 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

//Initialisation du modele de la trame
long long int trame = 1;
int trame1 = 1;
int trame2 = 0;
long long int preamble = 0;
long long int reset_trame = 0xFFFFFE0; // Trame qui reinitialise la memoire du train : 111111111111111111111110000000000000000000000000000000000001
int reset_trame1 = 0xF0000001;
int reset_trame2 = 0x7FFFF;

//octets pour la generation de l'octet de controle
unsigned int octet2=0; //octet de commande 1
unsigned int octet3=0; //octet de commande 2
unsigned int octet_ctrl=0; //octet de controle

unsigned int fct_F0toF4 = 0; //fonction(s) courante F0 a F4
unsigned int fct_F5toF12 = 0; //fonction(s) courante F5 a F12
unsigned int fct_F13toF20 = 0; //fonction(s) courante F13 a F20

unsigned int data_led5 = 0;
unsigned int data_led = 0;   //valeur a afficher sur le 7 segment
unsigned int data_switch = 0; //etat des switch pour l'afficheur des 7 segment

unsigned int mem_fct_F0toF4 = 0; //fonction(s) precedentes F0 a F4
unsigned int mem_fct_F5toF12 = 0; //fonction(s) precedentes F5 a F12
unsigned int mem_fct_F13toF20 = 0; //fonction(s) precedentes F13 a F20

unsigned int adr=1; //adresse du train (1 par defaut)
int cpt_speed_av=0; //compteur vitesse marche avant
int cpt_speed_ar=0; //compteur vitesse marche arriere
int cpt_fct=0; //compteur fonction
int mem_cpt_fct=0; //compteur fonction (pour affichage 7 SEGMENT)
int mem_btn_C_data_led5 = 0; //pour l'affichage sur le 7 segment de la desactivation d'une fonction

int send_speed_av = 0; //configuration vitesse marche avant
int send_speed_ar = 0; //configuration vitesse marche arriere
int send_fct = 0;   //configuration fonction
int send_reset_trame = 0; //flag pour l'envoi d'une trame de reset

XGpio led, sw, bouton;

//etats PRESENTS des boutons et switch
int sw_state, btn_state;
int sw_adr; // switch de configuration d'adresse
int sw_speed_av; //switch de configuration de vitessse marche avant
int sw_speed_ar; //switch de configuration de vitessse marche arri
int sw_fct; //switch qui controle de fonction
int sw_reset_trame;

int btn_state=0;
int btn_C=0;
int btn_G=0;
int btn_D=0;
int btn_H=0;
int btn_B=0;

//etats PRECEDENTS des boutons
int mem_btn_C = 0,mem_btn_G = 0,mem_btn_D = 0,mem_btn_H = 0,mem_btn_B = 0;


void Init_GPIO(){
    XGpio_Initialize(&led, XPAR_LED_SWITCH_DEVICE_ID); XGpio_SetDataDirection(&led, 2, 0);  //PORT A VERIFIER
    XGpio_Initialize(&sw, XPAR_LED_SWITCH_DEVICE_ID); XGpio_SetDataDirection(&sw, 1, 1);    //PORT A VERIFIER
    XGpio_Initialize(&bouton, XPAR_BOUTONS_DEVICE_ID); XGpio_SetDataDirection(&bouton, 1, 1);//PORT A VERIFIER
}

//fonction de lecture des switch
void read_sw(){
    sw_state = XGpio_DiscreteRead(&sw, 1);
    sw_adr = sw_state & 1;
    sw_speed_av = (sw_state & 2) >> 1;
    sw_speed_ar = (sw_state & 4) >> 2;
    sw_fct = (sw_state & 8) >> 3;
    sw_reset_trame = (sw_state & (1 << 14)) >> 14;
}

//fonction de lecture des boutons
void read_btn(){
    btn_state = XGpio_DiscreteRead(&bouton, 1);
    btn_C = btn_state & 1;
    //btn_G = (btn_state & 4) >> 2;
    //btn_D = (btn_state & 8) >> 3;
    btn_H = (btn_state & 2) >> 1;
    btn_B = (btn_state & 16) >> 4;
}

//fonction de construction et envoi de la trame
void send_trame(){
    //-------------------------------------------FONCTIONS----------------------------------------------//
    if(cpt_fct <= 20 && cpt_fct >= 13 && send_fct){
        //----------------------------------FONCTIONS F13 a F20-----------------------------------------//
        preamble = 0x3FFF; //F13 a F20 --> Preambule de 14 bits a 1
        if( (fonctions_actif[cpt_fct]) ){ //La fonction est deja active -> on la desactive
            octet2 = (fonctions[cpt_fct] & 0xFF00) >> 8;
            mem_fct_F13toF20 &= ~(fonctions_OFF[cpt_fct] & 0x00FF);
            octet3 = mem_fct_F13toF20;
            octet_ctrl = adr ^ octet2 ^ octet3;
            data_led5 = 1;
            fonctions_actif[cpt_fct] = 0; // mise en statut NON actif de la fonction
        }else{ //La fonction n'est pas active -> on l'active
            octet2 = (fonctions[cpt_fct] & 0xFF00) >> 8;
            fct_F13toF20 = fonctions[cpt_fct] & 0x00FF;
            mem_fct_F13toF20 |= fct_F13toF20;
            octet3 = mem_fct_F13toF20;
            octet_ctrl = adr ^ octet2 ^ octet3;
            fonctions_actif[cpt_fct] = 1; // mise en statut actif de la fonction
        }
        //construction de la trame
        trame1 &= ~((0xF << 28) | (0xFF << 19) | (0xFF << 10) | (0xFF << 1));
        trame2 &= ~(0x7FFF);

        trame1 |= ((adr & 0xF) << 28) | ((octet2 << 19) | (octet3 << 10) | (octet_ctrl << 1));
        trame2 |= (preamble << 5) | ((adr & 0xF0) >> 4) ;

        send_fct = 0; //acquittement envoi configuration de fonction
        cpt_fct = 0;
    }else{//F0 a F12 ou commande vitesse --> Preambule de 23 bits a 1
        preamble = 0x7FFFFF;
        //----------------------------------FONCTIONS F0 a F12-----------------------------------------//
        if(cpt_fct <= 12 && cpt_fct >= 0 && send_fct){//F0 a F12

            if(cpt_fct >= 0 && cpt_fct <= 4){//F0 a F4
                if( (fonctions_actif[cpt_fct]) ){ //La fonction est deja active -> on la desactive
                    mem_fct_F0toF4 &= ~(fonctions_OFF[cpt_fct] & 0x00FF);
                    octet2 = mem_fct_F0toF4;
                    octet_ctrl = adr ^ octet2;
                    data_led5 = 1;
                    fonctions_actif[cpt_fct] = 0; // mise en statut NON actif de la fonction
                }else{ //La fonction n'est pas active -> on l'active
                    fct_F0toF4 = fonctions[cpt_fct] & 0x00FF;
                    mem_fct_F0toF4 |= fct_F0toF4;
                    octet2 = mem_fct_F0toF4;
                    octet_ctrl = adr ^ octet2;
                    fonctions_actif[cpt_fct] = 1; // mise en statut actif de la fonction
                }
            }

            if(cpt_fct >= 5 && cpt_fct <= 12){//F5 a F12
                if( (fonctions_actif[cpt_fct]) ){ //La fonction est deja active -> on la desactive
                    mem_fct_F5toF12 &= ~(fonctions_OFF[cpt_fct] & 0x00FF);
                    octet2 = mem_fct_F5toF12;
                    octet_ctrl = adr ^ octet2;
                    data_led5 = 1;
                    fonctions_actif[cpt_fct] = 0; // mise en statut NON actif de la fonction
                }else{ //La fonction n'est pas active -> on l'active
                    fct_F5toF12 = fonctions[cpt_fct] & 0x00FF;
                    mem_fct_F5toF12 |= fct_F5toF12;
                    octet2 = mem_fct_F5toF12;
                    octet_ctrl = adr ^ octet2;
                    fonctions_actif[cpt_fct] = 1; // mise en statut actif de la fonction
                }
            }
            send_fct = 0; //acquittement envoi configuration de fonction
            cpt_fct = 0;
        }
        //----------------------------------MARCHE AVANT-----------------------------------------//

        if( send_speed_av){ //Vitesse marche avant
            octet2 = vitesse_av[cpt_speed_av] & 0x00FF;
            octet_ctrl = adr ^ octet2;
            send_speed_av = 0; //acquittement envoi configuration de fonction
            cpt_speed_av = 0;
        }

        //----------------------------------MARCHE ARRIERE-----------------------------------------//
        if( send_speed_ar){ //Vitesse marche arriere
            octet2 = vitesse_ar[cpt_speed_ar] & 0x00FF;
            octet_ctrl = adr ^ octet2;
            send_speed_ar = 0; //acquittement envoi configuration de fonction
            cpt_speed_ar = 0;
        }

        //construction de la trame
        trame1 &= ~((0xF << 28) | (0xFF << 19) | (0xFF << 10) | (0xFF << 1));
        trame2 &= ~(0x7FFF);

        trame1 |= ((preamble & 0xF) << 28) | ((adr << 19) | (octet2 << 10) | (octet_ctrl << 1));
        trame2 |= (preamble & 0x7FFFF);

        //La trame a envoyer est un reset de la memoire du train
        if (send_reset_trame){
        	trame1 = reset_trame1;
            trame2 = reset_trame2;
            send_reset_trame = 0;
        }
    }
    //ecriture dans les registres du BUS AXI
    MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG0_OFFSET, trame1);
    MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG1_OFFSET, trame2);
}



int main(){

    Init_GPIO();

    while(1){
        read_sw();
        read_btn();
        if(!sw_adr && !sw_speed_av && !sw_speed_ar && !sw_fct && !sw_reset_trame){ // affichage du mot dCC sur l'afficheur 7 segment si aucun interrupteur n'est leve
			XGpio_DiscreteWrite(&led, 2, 0);
			MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, 0);
		}

        //configuration de l'adresse
        if(sw_adr && !sw_speed_av && !sw_speed_ar && !sw_fct && !sw_reset_trame){
        	if(btn_H && !mem_btn_H){ //Detection d'un appui du bouton haut -> incrementation de l'adresse
                adr++;
                if (adr>=7 || adr<=0 ) adr=1;
                mem_btn_H = 1;
                XGpio_DiscreteWrite(&led, 2, adr);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, adr);
            }

            if(btn_B && !mem_btn_B){ //Detection d'un appui du bouton bas -> decrementation de l'adresse
                adr--;
                if (adr>=7 || adr<=0 ) adr=1;
                mem_btn_B = 1;
                XGpio_DiscreteWrite(&led, 2, adr);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, adr);
            }
        	XGpio_DiscreteWrite(&led, 2, adr);
        	MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, adr);
        }

        //configuration de la vitesse marche AVANT
        if(!sw_adr && sw_speed_av && !sw_speed_ar && !sw_fct && !sw_reset_trame){
            if(btn_H && !mem_btn_H){ //Detection d'un appui du bouton haut -> incrementation de la vitesse
                send_speed_av = 1;
                cpt_speed_av++;
                if (cpt_speed_av >= 32 || cpt_speed_av <= -1){ cpt_speed_av=0;}
                mem_btn_H = 1;
                XGpio_DiscreteWrite(&led, 2, cpt_speed_av);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, cpt_speed_av);
            }

            if(btn_B && !mem_btn_B){ //Detection d'un appui du bouton bas -> decrementation de la vitesse
                send_speed_av = 1;
                cpt_speed_av--;
                if (cpt_speed_av >= 32 || cpt_speed_av <= -1) cpt_speed_av=0;
                mem_btn_B = 1;
                XGpio_DiscreteWrite(&led, 2, cpt_speed_av);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, cpt_speed_av);
            }
            send_speed_ar = 0;
            send_fct = 0;
            send_reset_trame = 0;
        }

        //configuration de la vitesse marche ARRIERE
        if(!sw_adr && !sw_speed_av && sw_speed_ar && !sw_fct && !sw_reset_trame){
            if(btn_H && !mem_btn_H){ //Detection d'un appui du bouton haut -> incrementation de la vitesse
                send_speed_ar = 1;
                cpt_speed_ar++;
                if (cpt_speed_ar >= 32 || cpt_speed_ar <= -1) cpt_speed_ar=0;
                mem_btn_H = 1;
                XGpio_DiscreteWrite(&led, 2, cpt_speed_ar);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, cpt_speed_ar);
            }

            if(btn_B && !mem_btn_B){ //Detection d'un appui du bouton bas -> decrementation de la vitesse
                send_speed_ar = 1;
                cpt_speed_ar--;
                if (cpt_speed_ar >= 32 || cpt_speed_ar <= -1) cpt_speed_ar=0;
                mem_btn_B = 1;
                XGpio_DiscreteWrite(&led, 2, cpt_speed_ar);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, cpt_speed_ar);
            }
            send_speed_av = 0;
            send_fct = 0;
            send_reset_trame = 0;
        }

        //configuration de la fonction
        if(!sw_adr && !sw_speed_av && !sw_speed_ar && sw_fct && !sw_reset_trame){
        	if(btn_H && !mem_btn_H){ //Detection d'un appui du bouton haut -> incrementation de la fonction
        		if(mem_btn_C_data_led5){
        			cpt_fct = 0;
        			mem_btn_C_data_led5 = 0;
        			mem_cpt_fct = 0;
        			data_led5 = 0;
        			data_led = 0;
					XGpio_DiscreteWrite(&led, 2, data_led);
					MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, data_led);
        		}
                send_fct = 1;
                cpt_fct++;
                if (cpt_fct >= 21 || cpt_fct <= -1) cpt_fct=0;
                mem_btn_H = 1;
                mem_cpt_fct = cpt_fct;
                data_led |= cpt_fct;
                XGpio_DiscreteWrite(&led, 2, data_led);
                MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, data_led);
            }
            if(btn_B && !mem_btn_B){ //Detection d'un appui du bouton bas -> decrementation de la fonction
            	if(mem_btn_C_data_led5){ //gestion de l'affiche sur 7 segment pour l'affichage d'une activation ou desactivation
            		cpt_fct = 0;
					mem_btn_C_data_led5 = 0;
					mem_cpt_fct = 0;
					data_led5 = 0;
					data_led = 0;
					XGpio_DiscreteWrite(&led, 2, data_led);
					MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, data_led);
            	}
                send_fct = 1;
                cpt_fct--;
                if (cpt_fct >= 21 || cpt_fct <= -1) cpt_fct=0;
                mem_btn_B = 1;
                mem_cpt_fct = cpt_fct;
                data_led |= cpt_fct;
				XGpio_DiscreteWrite(&led, 2, data_led);
				MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, data_led);
			}
            send_speed_av = 0;
            send_speed_ar = 0;
            send_reset_trame = 0;
        }

        //configuration trame de reset
        if(!sw_adr && !sw_speed_av && !sw_speed_ar && !sw_fct && sw_reset_trame){
            send_reset_trame = 1;
        	send_trame();
        }

        //envoi de la trame
        if(btn_C && !mem_btn_C){
			send_trame();
			mem_btn_C = 1;
			mem_btn_C_data_led5 = 1;
        }

        if(!btn_H) mem_btn_H=0; //gestion du rebond bouton Up
        if(!btn_B) mem_btn_B=0; //gestion du rebond bouton Down
        if(!btn_C) mem_btn_C=0; //gestion du rebond bouton Center

    	data_led = 0;
        if(data_led5){ //gestion de l'ecriture 
			data_led |= 1<<5 | mem_cpt_fct;
			XGpio_DiscreteWrite(&led, 2, data_led);
			MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG2_OFFSET, data_led);
		}

		if(sw_state & (1 << 14))data_switch |= 1<<4; // affichage du mot rstF (reset frame) sur l'afficheur 7 segment
		else data_switch &= ~(1<<4);

		if(sw_state & (1 << 3))data_switch |= 1<<3; // affichage du mot FC/CL (Fonction/Clear) sur l'afficheur 7 segment
		else data_switch &= ~(1<<3);

		if(sw_state & (1 << 2))data_switch |= 1<<2;  // affichage du mot Sb (Speed backward) sur l'afficheur 7 segment
		else data_switch &= ~(1<<2);

		if(sw_state & (1 << 1))data_switch |= 1<<1; // affichage du mot SF (Speed forward) sur l'afficheur 7 segment
		else data_switch &= ~(1<<1);

		if(sw_state & (1 << 0))	data_switch |= 1<<0; // affichage du mot Adr (adresse) sur l'afficheur 7 segment
		else data_switch &= ~(1<<0);

		MY_TOP_DCC_mWriteReg(XPAR_MY_TOP_DCC_0_S00_AXI_BASEADDR, MY_TOP_DCC_S00_AXI_SLV_REG3_OFFSET, data_switch);

    }

    return 0;
}
